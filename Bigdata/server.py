from flask import Flask, request, jsonify, make_response
from flask_restx import Api, Resource, fields
from confluent_kafka import Consumer, KafkaError, Producer
import time
from flask_cors import CORS 
import json
from pyspark.sql import SparkSession
from pyspark.sql import SQLContext
from pyspark.sql.functions import col, when, regexp_extract, concat, lit, to_date
import boto3

app = Flask(__name__)
api = Api(
    app,
    version="1.0",
    title="ML App",
    description="Predict results using a trained model"
)

producer_conf = {
    'bootstrap.servers': '127.0.0.1:9092'
}

producer = Producer(producer_conf)


name_space = api.namespace('prediction', description='Prediction APIs')


spark = SparkSession.builder\
    .appName("CSVToAthena")\
    .config("spark.jars.packages", "com.amazon.redshift:redshift-jdbc42:2.1.0.23") \
    .getOrCreate()
sql_context = SQLContext(spark)


jdbc_url= "jdbc:redshift://default-workgroup.644818306894.us-east-1.redshift-serverless.amazonaws.com:5439/dev"
properties = {
    "user": "admin",
    "password": "Data$123",
    "driver": "com.amazon.redshift.jdbc.Driver"
}

def endresult(data):
    print("in endresult", data)
    answer = "Jai Balayya"
    
    json_data = json.dumps(data)

    # Message to send
    message = "Your message here"  # Replace with your desired message

    # Send the message to Kafka topic 'mytopic'
    producer.produce('mytopic', value=json_data.encode('utf-8'))
    producer.flush()

    sql_query = """
    SELECT 
        MIN(Total_Compensation) AS MinCompensation,
        MAX(Total_Compensation) AS MaxCompensation,
        AVG(Total_Compensation) AS AvgCompensation,
        SUM(Total_Compensation) AS TotalCompensation
    FROM employeedata
    """
    result_df = spark.read \
    .format("jdbc") \
    .option("url", jdbc_url) \
    .option("dbtable", f"({sql_query}) AS query_alias") \
    .option("user", properties["user"]) \
    .option("password", properties["password"]) \
    .option("driver", properties["driver"]) \
    .load()

    result_df.show()
    json_result = result_df.toJSON().collect()

    return json_result

consumer_conf = {
    'bootstrap.servers': '127.0.0.1:9092',
    'group.id': 'my-group',  # Choose a consumer group ID
    'auto.offset.reset': 'earliest'  # Start consuming from the beginning of the topic
}


# Function to consume messages from Kafka topic
def consume_kafka_topic(topic):
    consumer = Consumer(consumer_conf)
    consumer.subscribe([topic])

    while True:
        msg = consumer.poll(timeout=1.0)

        if msg is None:
            continue
        if msg.error():
            if msg.error().code() == KafkaError._PARTITION_EOF:
                continue
            else:
                print(msg.error())
                break

        print('Received message: {}'.format(msg.value().decode('utf-8')))
        # Add your processing logic here

    consumer.close()


def start_kafka_consumer():
    topic = 'mytopic'  # Replace with your Kafka topic
    consume_kafka_topic(topic)

@name_space.route("/")
class MainClass(Resource):

    def options(self):
        response = make_response()
        response.headers.add("Access-Control-Allow-Origin", "*")
        response.headers.add('Access-Control-Allow-Headers', "*")
        response.headers.add('Access-Control-Allow-Methods', "*")
        return response
    
    def post(self):
        try: 
            print("Hi ra")
            formData = request.json
            data = [val for val in formData.values()]
            
            
            response = jsonify({
                "statusCode": 200,
                "status": "Prediction made",
                "result": "Prediction: " + str(endresult(formData))
                })
            response.headers.add('Access-Control-Allow-Origin', '*')
            return response
        except Exception as error:
            return jsonify({
                "statusCode": 500,
                "status": "Could not make prediction",
                "error": str(error)
            })

if __name__ == "__main__":
    CORS(app) 
    app.run(debug=True)
    # time.sleep(5)
    # print("sleep done")
    # start_kafka_consumer()
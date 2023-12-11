from confluent_kafka import Consumer, KafkaError
from pyspark.sql import SparkSession
from pyspark.sql import SQLContext
from pyspark.sql.functions import col, when, regexp_extract, concat, lit, to_date
import boto3

# Kafka broker and topic configuration
bootstrap_servers = 'localhost:9092'
topic = 'mytopic'
group_id = 'my-group'  # Choose a consumer group ID



# Create Consumer instance configuration
consumer_conf = {
    'bootstrap.servers': bootstrap_servers,
    'group.id': group_id,
    'auto.offset.reset': 'earliest'  # Start consuming from the beginning of the topic
}

# Create Kafka Consumer instance
consumer = Consumer(consumer_conf)

# Subscribe to the topic
consumer.subscribe([topic])


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

try:
    while True:
        # Poll for messages
        msg = consumer.poll(timeout=1.0)

        if msg is None:
            continue
        if msg.error():
            if msg.error().code() == KafkaError._PARTITION_EOF:
                continue
            else:
                print(msg.error())
                break

        # Process received message
        #print(f"Received message: {msg.value().decode('utf-8')}")
        df = spark.read.json(spark.sparkContext.parallelize([msg.value().decode('utf-8')]))
        df.show()
        df.write.format("jdbc") \
            .option("url", jdbc_url) \
            .option("dbtable", "EmployeeData") \
            .option("user", properties["user"]) \
            .option("password", properties["password"]) \
            .option("driver", properties["driver"]) \
            .mode("append") \
            .save()
        print("saved")
except Exception as e:
    print("error")
    print(e)
except KeyboardInterrupt:
    pass

finally:
    # Close down consumer to commit final offsets.
    consumer.close()

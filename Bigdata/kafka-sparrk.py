from pyspark.sql import SparkSession

# Create a SparkSession
spark = SparkSession.builder \
    .appName("KafkaSparkStructuredStreaming") \
    .getOrCreate()

# Read messages from Kafka using the structured streaming API
kafka_df = spark \
    .readStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers", "127.0.0.1:9092") \
    .option("subscribe", "mytopic") \
    .load()

# Perform any required transformations or processing
# For example, select columns and display the data
query = kafka_df.selectExpr("CAST(key AS STRING)", "CAST(value AS STRING)") \
    .writeStream \
    .outputMode("append") \
    .format("console") \
    .start()

# Start the streaming query
query.awaitTermination()
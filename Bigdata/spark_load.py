from pyspark.sql import SparkSession
from pyspark.sql import SQLContext
from pyspark.sql.functions import col, when, regexp_extract, concat, lit, to_date
import boto3

# sc = SparkContext(appName='MySparkApp')
# sql_context = SQLContext(sc)

# secretsmanager_client = boto3.client('secretsmanager', region = "")
# Initialize Spark Session
spark = SparkSession.builder\
    .appName("CSVToAthena")\
    .config("spark.jars.packages", "com.amazon.redshift:redshift-jdbc42:2.1.0.23") \
    .config("spark.driver.extraClassPath", "/Users/sandbhim/project/big_data/lib/lib/lib/redshift-jdbc42-2.1.0.23.jar")\
    .config("spark.executor.extraClassPath", "/Users/sandbhim/project/big_data/lib/lib/redshift-jdbc42-2.1.0.23.jar")\
    .getOrCreate()
sql_context = SQLContext(spark)

# Read CSV file into DataFrame
csv_file_path = "/Users/sandbhim/project/big_data/data/Employee_Compensation.csv"
employees_df = spark.read.csv(csv_file_path, header=True)


jdbc_url= "jdbc:redshift://default-workgroup.644818306894.us-east-1.redshift-serverless.amazonaws.com:5439/dev"
properties = {
    "user": "admin",
    "password": "Data$123",
    "driver": "com.amazon.redshift.jdbc.Driver"
}
#print(employees_df.head())
# Process the data (example: performing some transformations)
processed_df = employees_df.select("Job Code", "Job")  # Replace with your actual processing logic

transformed_df = employees_df \
    .withColumnRenamed("Organization Group Code", "Organization_Group_Code") \
    .withColumnRenamed("Job Family Code", "Job_Family_Code") \
    .withColumnRenamed("Job Code", "Job_Code") \
    .withColumnRenamed("Year Type", "Year_Type") \
    .withColumnRenamed("Organization Group", "Organization_Group") \
    .withColumnRenamed("Department Code", "Department_Code") \
    .withColumnRenamed("Union Code", "Union_Code") \
    .withColumnRenamed("Job Family", "Job_Family") \
    .withColumnRenamed("Employee Identifier", "Employee_Identifier") \
    .withColumnRenamed("Other Salaries", "Other_Salaries") \
    .withColumnRenamed("Total Salary", "Total_Salary") \
    .withColumnRenamed("Health and Dental", "Health_and_Dental") \
    .withColumnRenamed("Other Benefits", "Other_Benefits") \
    .withColumnRenamed("Total Benefits", "Total_Benefits") \
    .withColumnRenamed("Total Compensation", "Total_Compensation") \
    .withColumn("Year", col("Year").cast("int")) \
    .withColumn("Salaries", col("Salaries").cast("decimal(15, 2)")) \
    .withColumn("Union_Name", regexp_extract(col("Union"), r"(.*),.*", 1)) \
    .withColumn("Total_Compensation", when(col("Total_Compensation") < 0, 0).otherwise(col("Total_Compensation")))

print(transformed_df.head())
query = "(SELECT table_name FROM information_schema.tables WHERE table_schema = 'public') tmp"
df_db = spark.read \
    .format("jdbc") \
    .option("url", jdbc_url) \
    .option("dbtable", query) \
    .option("user", properties["user"]) \
    .option("password", properties["password"]) \
    .option("driver", properties["driver"]) \
    .load()
df_db.show()

# Define the number of partitions for batching
num_partitions = 1000  # Adjust the number based on your data size and requirements

# Partition the DataFrame by a column (for example, 'Employee_Identifier')
partitioned_df = transformed_df.repartition(num_partitions, "Employee_Identifier")
#first_partition = partitioned_df.filter(partitioned_df.Employee_Identifier % num_partitions == 0)
# head_df = transformed_df.limit(1)

# print(head_df)
# print(transformed_df.count())
# #print(first_partition.count())
# print(partitioned_df.count())

def process_partition(iterator):
    # Your custom processing or print statements here
    print("Processing partition...")
    print(type(iterator))
    # iterator.write.format("jdbc") \
    #     .option("url", jdbc_url) \
    #     .option("dbtable", "EmployeeData") \
    #     .option("user", properties["user"]) \
    #     .option("password", properties["password"]) \
    #     .option("driver", properties["driver"]) \
    #     .mode("overwrite") \
    #     .save()
    print("Partition saved successfully.")

# partitioned_df.foreachPartition(process_partition)


partitioned_df.write.format("jdbc") \
    .option("url", jdbc_url) \
    .option("dbtable", "EmployeeData") \
    .option("user", properties["user"]) \
    .option("password", properties["password"]) \
    .option("driver", properties["driver"]) \
    .mode("overwrite") \
    .save()
print(df_db)
# # Write processed data to Athena


spark.stop()


admin 

Data$123

mvn install:install-file \
   -Dfile=/Users/sandbhim/project/big_data/lib/redshift-jdbc42-2.1.0.23.jar \
   -DgroupId=com.amazon.redshift \
   -DartifactId=redshift-jdbc42 \
   -Dversion=2.1.0.23 \
   -Dpackaging=jar \
   -DgeneratePom=true


-- CREATE TABLE EmployeeData (
--     id INT IDENTITY(1,1) PRIMARY KEY,
--     Organization_Group_Code VARCHAR(10),
--     Job_Family_Code VARCHAR(10),
--     Job_Code VARCHAR(10),
--     Year_Type VARCHAR(10),
--     Year VARCHAR(10),
--     Organization_Group VARCHAR(100),
--     Department_Code VARCHAR(10),
--     Department VARCHAR(100),
--     Union_Code VARCHAR(10),
--     Union_Name VARCHAR(100),
--     Job_Family VARCHAR(100),
--     Job_Title VARCHAR(100),
--     Employee_Identifier VARCHAR(20),
--     Salaries DECIMAL(15, 2),
--     Overtime DECIMAL(15, 2),
--     Other_Salaries DECIMAL(15, 2),
--     Total_Salary DECIMAL(15, 2),
--     Retirement DECIMAL(15, 2),
--     Health_and_Dental DECIMAL(15, 2),
--     Other_Benefits DECIMAL(15, 2),
--     Total_Benefits DECIMAL(15, 2),
--     Total_Compensation DECIMAL(15, 2)
-- );

https://github.com/aws/amazon-redshift-jdbc-driver

https://docs.aws.amazon.com/redshift/latest/mgmt/serverless-connecting.html

https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-spark-redshift-auth.html


https://archive.apache.org/dist/kafka/2.3.0/ --- kafka_2.11-2.3.0.tgz 

pip3 install --upgrade Flask==1.1.2
pip3 install --upgrade confluent_kafka==0.9.1
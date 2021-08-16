from pyspark.sql import SparkSession
from delta.tables import *
from pyspark.sql.functions import col, min, max

# Init the Spark Session
spark = (SparkSession.builder.appName("DeltaPoc")
    .config("spark.jars.packages", "io.delta:delta-core_2.12:1.0.0")
    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension")
    .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")
    .getOrCreate()
)

# Read CSV
censo = (
    spark.read.format("csv")
    .option("inferSchema", True)
    .option("header", True)
    .option("delimiter", "|")
    .load("s3://datalake-edc-raw-data/censo/matricula_*.CSV")
)

# Writing delta table
print("Writing delta table...")
(
    censo
    .write
    .mode("overwrite")
    .format("delta")
    .partitionBy("CO_UF")
    .save("s3://datalake-edc-staging-zone/censo")
)

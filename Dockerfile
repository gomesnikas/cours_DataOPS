FROM apache/airflow:2.5.0

# Installer dbt pour Postgres
RUN pip install dbt-postgres

# Installer Great Expectations
RUN pip install great_expectations


RUN apt-get update && apt-get install -y gcc build-essential
 
USER airflow
RUN pip install --no-cache-dir \
    great-expectations==0.15.46 \
    dbt-postgres==1.5.2 \
    protobuf==3.20.3 \
    nbformat>=5.1.0
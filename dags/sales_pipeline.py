from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
}

with DAG(
    dag_id='sales_data_pipeline',
    default_args=default_args,
    description='Pipeline DataOps automatisé avec Airflow, dbt, GE',
    schedule_interval='@daily',
    start_date=days_ago(1),
    catchup=False,
    tags=['dataops'],
) as dag:

    # Étape 1 : Ingestion fictive (copie du fichier sales.csv)
    ingest_data = BashOperator(
        task_id='ingest_sales_data',
        bash_command='cp /opt/airflow/data/sales.csv /opt/airflow/processed/sales.csv'
    )

    # Étape 2 : Transformation avec dbt
    dbt_run = BashOperator(
        task_id='run_dbt_models',
        bash_command='cd /usr/app && dbt run',
        env={
            'DBT_PROFILES_DIR': '/usr/app'
        }
    )

    # Étape 3 : Validation avec Great Expectations
    run_ge_validation = BashOperator(
        task_id='validate_with_ge',
        bash_command='great_expectations checkpoint run sales_checkpoint',
        cwd='/app/great_expectations'
    )

    ingest_data >> dbt_run >> run_ge_validation

from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

# Configuração padrão da DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Definição da DAG
with DAG(
    'dbt_pipeline_dag',
    default_args=default_args,
    description='Pipeline para rodar DBT no Airflow',
    schedule='0 2 * * *',
    start_date=datetime(2025, 1, 20),
    catchup=False,
) as dag:

    # Tarefa 1: Clonar o repositório do GitHub
    clone_repo = BashOperator(
        task_id='clone_repo',
        bash_command=(
            'rm -rf /home/henriquevrios/meu_airflow/dbt_project && '
            'mkdir -p /home/henriquevrios/meu_airflow/dbt_project && '
            'git clone https://github.com/henriquevrios/academy-dbt.git /home/henriquevrios/meu_airflow/dbt_project'
        )
    )

    # Tarefa 2: Instalar o dbt deps
    dbt_deps = BashOperator(
        task_id='dbt_deps',
        bash_command=(
            'cd /home/henriquevrios/meu_airflow/dbt_project && '
            'dbt deps --profiles-dir /home/henriquevrios/meu_airflow/dbt_profiles && '
            'echo "dbt deps completed"'
        )
    )

    # Tarefa 3: Rodar as transformações do dbt
    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command=(
            'cd /home/henriquevrios/meu_airflow/dbt_project && '
            'dbt run --profiles-dir /home/henriquevrios/meu_airflow/dbt_profiles'
        )
    )

    # Tarefa 4: Rodar os testes do dbt
    dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command=(
            'cd /home/henriquevrios/meu_airflow/dbt_project && '
            'dbt test --profiles-dir /home/henriquevrios/meu_airflow/dbt_profiles'
        ),
        retries=3
    )

    # Definir a ordem das tarefas
    clone_repo >> dbt_deps >> dbt_run >> dbt_test

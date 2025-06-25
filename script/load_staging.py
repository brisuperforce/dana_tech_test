import glob
import os
from pathlib import Path

import yaml
from helpers.postgres_helper import PostgresHelper

if __name__ == "__main__":
    hostname = "host.docker.internal"
    port = 5434
    database_name = "dana"
    user = "dana"
    password = "dana123"
    schema = "staging"
    parent_path = Path().resolve().parent

    yelp_dataset_path = os.path.join(
        parent_path, "dana_tech_test/data_sources/yelp_dataset/csv/"
    )
    csv_dataset_path = os.path.join(parent_path, "dana_tech_test/data_sources/csv/")
    config_file_path = os.path.join(
        parent_path, "dana_tech_test/script/config/staging/load_staging.yaml"
    )

    with open(config_file_path, "r") as yaml_file:
        sources = yaml.safe_load(yaml_file)

        # load yelp source tables
        for table_name in sources["list_tables"]["yelp_source"]:
            print(f"Process: will load tables {table_name} from json")
            csv_path = yelp_dataset_path + f"{table_name}/"
            csv_pattern = os.path.join(csv_path, "*.csv")
            file_list = glob.glob(csv_pattern)
            target_table_name = f"{schema}.{table_name}"

            for file in file_list:
                print(f"[Job Info]: Will write file '{file}' to Postgre")
                PostgresHelper.load_to_postgres(
                    csv_path=file,
                    table=target_table_name,
                    hostname=hostname,
                    port=port,
                    database_name=database_name,
                    user=user,
                    password=password,
                    delimiter="~",
                )

        # load csv source tables
        for table_name in sources["list_tables"]["csv_source"]:
            print(f"Process: will load tables {table_name} from json")
            csv_path = csv_dataset_path + f"{table_name}/"
            csv_pattern = os.path.join(csv_path, "*.csv")
            file_list = glob.glob(csv_pattern)
            target_table_name = f"{schema}.{table_name}"

            for file in file_list:
                print(f"[Job Info]: Will write file '{file}' to Postgre")
                PostgresHelper.load_to_postgres(
                    csv_path=file,
                    table=target_table_name,
                    hostname=hostname,
                    port=port,
                    database_name=database_name,
                    user=user,
                    password=password,
                    delimiter=",",
                )

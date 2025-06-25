import logging
import os
from pathlib import Path

import yaml
from helpers.postgres_helper import PostgresHelper

if __name__ == "__main__":
    hostname = "localhost"
    port = 5434
    database_name = "dana"
    user = "dana"
    password = "dana123"
    parent_path = Path().resolve().parent
    ddl_path = os.path.join(parent_path, "dana_tech_test/sql/ods")
    config_file_path = os.path.join(
        parent_path, "dana_tech_test/script/config/ods/load_ods.yaml"
    )

    with open(config_file_path, "r") as yaml_file:
        sources = yaml.safe_load(yaml_file)

        # load yelp source tables
        for table_name in sources["list_tables"]:
            logging.info(
                f"[Job info]: will create table {table_name} if not exist in DB"
            )
            PostgresHelper.load_table(
                table_name=table_name,
                hostname=hostname,
                port=port,
                database_name=database_name,
                user=user,
                password=password,
                ddl_source_path=ddl_path,
            )
            logging.info(f"[Job info]: create table {table_name} success!")

import logging

import pandas as pd
import psycopg2


class PostgresHelper:
    @staticmethod
    def extract_source_table(db_connection: psycopg2.connect, query: str):
        """Extract data from source table"""

        df = pd.read_sql(sql=query, con=db_connection)
        return df

    @staticmethod
    def get_db_connection(
        hostname: str, port: int, database: str, user: str, password: str
    ) -> psycopg2.connect:
        """This function used for getting database connection

        Parameters
        ----------
        hostname : str
            Hostname of the postgres server
        port : int
            Port of the postgres server
        database : str
            Name of the database to connect to
        user : str
            Username of the postgres server
        password : str
            Password of the postgres server

        Returns
        -------
        psycopg2.connect
            Database connection
        """
        try:
            connection = psycopg2.connect(
                host=hostname,
                port=port,
                database=database,
                user=user,
                password=password,
            )
            return connection
        except Exception as e:
            logging.info(f"Catch Exception: {str(e)}")
            raise Exception

    @staticmethod
    def load_table(
        table_name: str,
        hostname: str,
        port: int,
        database_name: str,
        user: str,
        password: str,
        ddl_source_path: str = None,
    ):
        """This function used for loading table from ddl file to postgres table

        Parameters
        ----------
        table_name : str
            Name of the table to load the data into
        hostname : str
            Hostname of the postgres server
        port : int
            Port of the postgres server
        database_name : str
            Name of the database to load the data into
        user : str
            Username of the postgres server
        password : str
            Password of the postgres server
        ddl_source_path : str
            Path to the ddl file

        Raises
        ------
        Exception
            If there is an error loading the table from the ddl file to the postgres table
        """

        # get db_connection
        db_connection = PostgresHelper.get_db_connection(
            hostname, port, database_name, user, password
        )

        cur = db_connection.cursor()

        print(f"[Job info]: Table '{table_name}' not found in database")

        with open(f"{ddl_source_path}/{table_name}.sql", "r") as f:
            create_table_statement = f.read()
            f.close()

        try:
            print(
                f"[Job info]: Will creating table with table name: {table_name}\n with statement {create_table_statement}"
            )
            cur.execute(create_table_statement)
            db_connection.commit()
            cur.close()
            print(f"[Job info]: Creating table {table_name} Success!!")
        except (Exception, psycopg2.DatabaseError) as e:
            raise Exception(f"Catch exception while creating table: {str(e)}")
        finally:
            if db_connection is not None:
                db_connection.close()

    @staticmethod
    def load_to_postgres(
        csv_path: str,
        table: str,
        hostname: str,
        port: int,
        database_name: str,
        user: str,
        password: str,
        delimiter: str = "~",
    ):
        """This function used for loading csv file to postgres table

        Parameters
        ----------
        csv_path : str
            Path to the csv file
        table : str
            Name of the table to load the data into
        hostname : str
            Hostname of the postgres server
        port : int
            Port of the postgres server
        database_name : str
            Name of the database to load the data into
        user : str
            Username of the postgres server
        password : str
            Password of the postgres server
        delimiter : str
            Delimiter of the csv file

        Raises
        ------
        Exception
            If there is an error loading the csv file to the postgres table
        """
        conn = PostgresHelper.get_db_connection(
            hostname, port, database_name, user, password
        )
        cursor = conn.cursor()

        try:
            with open(csv_path, "r", encoding="utf-8") as f:
                copy_sql = f"""
                    COPY {table}
                    FROM STDIN
                    WITH (
                        FORMAT CSV,
                        DELIMITER '{delimiter}',
                        QUOTE '"',
                        ESCAPE '"',
                        HEADER TRUE
                    )
                """
                cursor.copy_expert(sql=copy_sql, file=f)
                conn.commit()
                print(f"[Job Info]: Loaded data into table '{table}' from '{csv_path}'")

        except (Exception, psycopg2.DatabaseError) as error:
            print(f"[Job Info]: Error loading CSV to table '{table}': {error}")
            conn.rollback()
            raise

        finally:
            cursor.close()
            conn.close()

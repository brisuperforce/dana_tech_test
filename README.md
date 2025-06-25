## Project : How Weather Affect Restaurant Ratting

This project ittend to know is bad weather affect restaurant ratting. This project using opensource dataset from Yelp.

To run this project, you need:
1. Pull this repository
2. Run the docker container with this command `docker-compose up -d`, this command will create postgres and enginer container, engine container is for running the script. when running thw postgres container is automatically create schema and tables.
3. Inside the engine container, consist 4 python scripts: 
    -- first script is `json_to_csv_converter.py`, this script will convert all json dataset into csv format.
    -- second is `load_staging.py`, this script will load all csv file into staging schema inside postgres DB.
    -- third is `load_staging_to_ods.py`, this script will insert data from staging schema into ods schema.
    -- last `load_ods_to_dwh.py`, this script will insert data from ods schema into data_warehouse schema.
4. You need to run script by this sequence `json_to_csv_converter.py` --> `load_staging.py` --> `load_staging_to_ods.py` --> `load_ods_to_dwh.py`
5. To run script you can use command `docker exec -it <container_id or name> uv run python script/<python file>`
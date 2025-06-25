import csv
import os
import shutil
from pathlib import Path

import pandas as pd
from helpers.directory_helper import create_directory, delete_directory


def copy_csv_file(source_dir: str, destination_dir: str, filename: str) -> None:
    """This function used for copying csv file from source directory to destination directory

    Parameters
    ----------
    source_dir : str
        Source directory of csv file
    destination_dir : str
        Destination directory of csv file
    filename : str
        Filename of csv file

    Raises
    ------
    FileNotFoundError
        Source file does not exist
    """

    os.makedirs(destination_dir, exist_ok=True)

    src_path = os.path.join(source_dir, filename)
    dst_path = os.path.join(destination_dir, filename)

    if not os.path.isfile(src_path):
        raise FileNotFoundError(f"Source file does not exist: {src_path}")

    shutil.copy2(src_path, dst_path)
    print(f"[Job Info]: Copied '{filename}' from '{source_dir}' to '{destination_dir}'")


def convert_json_to_csv(source_path: str, table_name: str) -> None:
    """This function used for converting json file to csv file

    Parameters
    ----------
    source_path : str
        Source path of json file
    table_name : str
        Table name of csv file
    """
    chunksize = 10**5
    output_path = f"{source_path}csv/{table_name}/"

    # delete the output directory if it exists to cleanup existing files
    delete_directory(output_path)
    # create the output directory
    create_directory(output_path)

    with pd.read_json(
        path_or_buf=source_path + f"yelp_academic_dataset_{table_name}.json",
        chunksize=chunksize,
        lines=True,
    ) as reader:
        for itterate_no, chunk in enumerate(reader):
            base_path = output_path
            filename = f"yelp_academic_dataset_{table_name}_{itterate_no}.csv"
            print(chunk.dtypes)
            chunk.replace(
                {
                    r"~": "",
                    r"\\": "",
                },
                regex=True,
                inplace=True,
            )

            chunk.to_csv(
                base_path + filename,
                sep="~",
                index=False,
                header=True,
                quoting=csv.QUOTE_MINIMAL,
                quotechar='"',
                escapechar='"',
                lineterminator="\n",
            )
            print(f"[Job Info]: write csv '{filename}'")


if __name__ == "__main__":
    parent_path = Path().resolve().parent
    predefined_data_path = os.path.join(parent_path, "dana_tech_test/data_sources/")
    predefined_output_path = os.path.join(
        parent_path, "dana_tech_test/data_sources/csv/"
    )
    json_path = os.path.join(parent_path, "dana_tech_test/data_sources/yelp_dataset/")
    # json_path = os.path.join(parent_path, "data_sources/yelp_dataset/")
    table_list = ["business", "checkin", "review", "tip", "user"]

    # converting json data source into csv format
    for table_name in table_list:
        print(f"[Job Info]: Will convert json file '{table_name}' to csv format")
        convert_json_to_csv(json_path, table_name)
        print(f"[Job Info]: covert file '{table_name}' to csv sucess!")

    # copy predefined percipitation and temperature data into csv format
    copy_csv_file(
        predefined_data_path,
        predefined_output_path + "/precipitation",
        "precipitation.csv",
    )
    copy_csv_file(
        predefined_data_path, predefined_output_path + "/temperature", "temperature.csv"
    )

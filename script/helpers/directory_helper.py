import logging
import os
import pathlib
import shutil


def create_directory(path: str) -> None:
    """This helper used for creating directory in local

    Parameters
    ----------
    path : str
        Directory path
    """

    pathlib.Path(f"{path}").mkdir(parents=True, exist_ok=True)
    logging.info(f"[Job info - directory]: Create folder: {path=}")


def delete_directory(path: str) -> None:
    """This helper used for deleting directory in local

    Parameters
    ----------
    path : str
        Directory path
    """

    if os.path.isdir(f"{path}"):
        shutil.rmtree(f"{path}")
        logging.info(f"[Job info -  directory]: Remove folder: {path=}")
    else:
        logging.info("[Job info - directory]: Path not found, skip deleting")

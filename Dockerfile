FROM python:3.12.10-slim

WORKDIR /usr/local/dana_tech_test

COPY ./  /usr/local/dana_tech_test

# Install uv using pip
RUN pip install --no-cache-dir uv

# Check uv is installed
RUN uv --version

RUN uv sync


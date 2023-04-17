FROM tiangolo/meinheld-gunicorn-flask:python3.8-alpine3.11

COPY ./requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir -r /app/requirements.txt

COPY ./app.py /app/app.py

ENV MODULE_NAME=app

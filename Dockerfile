FROM python:3.12

ARG PORT
ENV PORT=$PORT

WORKDIR /app

# copy the requirements files
COPY pyproject.toml poetry.lock /app/

RUN pip install poetry

RUN poetry config virtualenvs.create false && poetry install --no-root -n

COPY . /app/

WORKDIR /app/backend

RUN python manage.py migrate

EXPOSE $PORT

CMD ["sh", "-c", "python manage.py runserver 0.0.0.0:$PORT"]
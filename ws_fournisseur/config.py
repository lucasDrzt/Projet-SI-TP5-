import os

basedir = os.path.abspath(os.path.dirname(__file__))


class Config:
    SQLALCHEMY_DATABASE_URI = (
        "postgresql+psycopg2://postgres:mysecretpassword@localhost:5432/postgres"
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False

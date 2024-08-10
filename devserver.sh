#!/bin/sh

source .venv/bin/activate
rye run python mysite/manage.py runserver $PORT

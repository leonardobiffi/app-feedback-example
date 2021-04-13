FROM python:3.8-alpine

# set python to be unbuffered
ENV PYTHONUNBUFFERED=1

# install required packages
RUN apk add --no-cache libffi-dev git openrc

# adding the gunicorn config
COPY config/config.py /etc/gunicorn/config.py

# install dependencies
COPY requirements.txt /www/requirements.txt
RUN pip install -r /www/requirements.txt

# copy source code
WORKDIR /www
COPY . /www

RUN chmod +x /www/runner.py

# exposing the port
EXPOSE 80

# and running gunicorn
CMD ["gunicorn" ,"--config", "/etc/gunicorn/config.py", "runner:app"]
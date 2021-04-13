FROM python:3.8-alpine

# set python to be unbuffered
ENV PYTHONUNBUFFERED=1

# set default config supervisor
ENV WORKERS=1

# Install supervisor
RUN apk add supervisor

# install dependencies
COPY requirements.txt /www/requirements.txt
RUN pip install -r /www/requirements.txt

# copy source code
WORKDIR /www
COPY . /www

# Configure supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# supervisord start
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
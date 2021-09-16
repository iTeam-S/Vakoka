FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install python3 python3-pip -y ; \
ln -sf /usr/bin/python3 /usr/bin/python ; 

ADD * /opt/

RUN pip3 install -r /opt/requirements.txt

WORKDIR /opt/

CMD gunicorn --bind 0.0.0.0:$PORT wsgi

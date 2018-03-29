FROM python:2

ADD deps /deps
RUN pip install -r requirements.txt
ADD assets/ /opt/resource/
RUN chmod +rx /opt/resource/*

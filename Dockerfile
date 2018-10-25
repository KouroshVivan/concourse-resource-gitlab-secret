FROM python:3.6.7-alpine
LABEL Description="Concourse gitlab secrets resource"
MAINTAINER kourosh.vivan@gmail.com

ADD requirements.txt /opt/
RUN pip install --upgrade --no-cache-dir -r /opt/requirements.txt

# install resource assets
ADD assets/ /opt/resource/

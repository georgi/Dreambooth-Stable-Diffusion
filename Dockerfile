FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04

ENV USE_TORCH=1
ARG DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        gnupg \
        git \
        curl \
        ncdu \
        iotop \
        bzip2 \
        python3-pip \
        python3-opencv \
        python3-venv \
        libglib2.0-0 \
        libgl1-mesa-glx \
        build-essential \
        libopencv-dev &&\
    apt-get clean && apt-get autoclean

WORKDIR /app
ADD Pipfile.lock /app/

RUN pip install pipenv
RUN pipenv install --system

ADD . . 

CMD exec bash

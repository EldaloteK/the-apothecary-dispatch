FROM python:3.12.0a5-slim-bullseye

RUN mkdir /app
WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

EXPOSE 5555

ENTRYPOINT ["/bin/bash"]
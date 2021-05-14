FROM ubuntu:bionic

RUN apt-get update && apt-get install -y git maven default-jre default-jdk wget
COPY wrapper-script.sh wrapper-script.sh
CMD chmod +x wrapper-script.sh && ./wrapper-script.sh

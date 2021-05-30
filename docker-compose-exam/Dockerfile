FROM ubuntu:bionic

ENV MYSQL_PWD 123456
RUN echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections
RUN apt-get update && apt-get install -y git maven default-jre default-jdk wget vim apt-utils mysql-server curl net-tools
COPY wrapper-script.sh wrapper-script.sh
CMD chmod +x wrapper-script.sh && ./wrapper-script.sh

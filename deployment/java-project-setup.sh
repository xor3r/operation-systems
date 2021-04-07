sudo apt-get install -y git default-jre default-jdk maven
git clone https://github.com/damoklov/spring-jpa-iot.git /home/server/spring-jpa-iot

export MYSQL_PWD=123456

/usr/bin/mysql -u root -e "CREATE DATABASE IF NOT EXISTS pazyniuk_jpa;"
/usr/bin/mysql -u root -e "FLUSH PRIVILEGES;"

cd /home/server/spring-jpa-iot/
mvn install
mvn clean package
timeout 30s mvn spring-boot:run

/usr/bin/mysql -u root pazyniuk_jpa < /home/server/spring-jpa-iot/src/main/resources/inserts.sql


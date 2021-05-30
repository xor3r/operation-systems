/etc/init.d/mysql start

cd
git clone -b docker-one-container https://github.com/damoklov/spring-jpa-iot.git
cd spring-jpa-iot/
mvn install
mvn clean package
timeout 30s mvn spring-boot:run

export MYSQL_PWD=123456
/usr/bin/mysql -u root -e "CREATE DATABASE IF NOT EXISTS pazyniuk_jpa;"
/usr/bin/mysql -u root -e "FLUSH PRIVILEGES;"
/usr/bin/mysql -u root pazyniuk_jpa < src/main/resources/inserts.sql
mvn spring-boot:run


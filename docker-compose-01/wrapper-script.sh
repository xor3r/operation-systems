cd
wget https://github.com/prometheus/prometheus/releases/download/v2.26.0/prometheus-2.26.0.linux-amd64.tar.gz
tar -xzf prometheus-2.26.0.linux-amd64.tar.gz
cd prometheus-2.26.0.linux-amd64/
rm -f prometheus.yml
wget https://raw.githubusercontent.com/damoklov/operation-systems/master/prometheus.yml
./prometheus &

cd
wget https://github.com/prometheus/node_exporter/releases/download/v1.1.2/node_exporter-1.1.2.linux-amd64.tar.gz
tar -xzf node_exporter-1.1.2.linux-amd64.tar.gz
cd node_exporter-1.1.2.linux-amd64/
./node_exporter &

cd
git clone -b docker https://github.com/damoklov/spring-jpa-iot.git
cd spring-jpa-iot/
mvn install
mvn clean package
mvn spring-boot:run

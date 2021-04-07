cd /home/server/deployment/

wget https://github.com/prometheus/prometheus/releases/download/v2.26.0/prometheus-2.26.0.linux-amd64.tar.gz
tar -xzf prometheus-2.26.0.linux-amd64.tar.gz
cd prometheus-2.26.0.linux-amd64/
rm -f prometheus.yml
mv /home/server/prometheus.yml ./
./prometheus &
PID1=$!

cd /home/server/deployment
wget https://github.com/prometheus/node_exporter/releases/download/v1.1.2/node_exporter-1.1.2.linux-amd64.tar.gz
tar -xzf node_exporter-1.1.2.linux-amd64.tar.gz
cd node_exporter-1.1.2.linux-amd64/
./node_exporter &
PID2=$!

cd /home/server/spring-jpa-iot
mvn spring-boot:run &
PID3=$!

echo "Prometheus is $PID1 and Node Exporter is $PID2 and Spring is $PID3"

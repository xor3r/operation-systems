echo "deb https://packages.grafana.com/oss/deb stable main" > /etc/apt/sources.list.d/grafana.list
curl https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo apt update
sudo apt-cache policy grafana
sudo apt install grafana

sudo systemctl start grafana-server
sudo systemctl enable grafana-server

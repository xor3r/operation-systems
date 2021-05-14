# Replace unique ID of Docker container with the one you run Java app in

cd /var/lib/docker/containers/0efe6e3ccaaef99607a4a6d3acbde71f1ac6abbbd6081f56d0bfb7638b941398
sudo tail -f 0efe6e3ccaaef99607a4a6d3acbde71f1ac6abbbd6081f56d0bfb7638b941398-json.log | grep --line-buffered -i SpringApplication | grep -i \"stream\":\"stderr\"

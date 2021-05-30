### SSH key-only connection

`ssh-keygen` - Generate keys for both server and client.

`ssh-copy-id server@192.168.32.129` - Copy key files from client to server, knowing server's password (example).

`ssh server@192.168.32.129` - Connect with keys only (example).

### Creating daemon which runs shell script using timer

To run script each 10 second, for example, we need to create service and timer for it.

__/etc/systemd/system/logger-exam.service__:
```Shell
[Unit]
Description=Logger
Wants=logger-exam.timer

[Service]
Type=oneshot
ExecStart=/bin/bash /home/server/exam/shell-script.sh

[Install]
WantedBy=multi-user.target
```

__/etc/systemd/system/logger-exam.timer__:
```Shell
[Unit]
Requires=logger-exam.service

[Timer]
Unit=logger-exam.service
OnCalendar=*-*-* *:*:0/10

[Install]
WantedBy=timers.target
```

__shell-script.sh__:
```Shell
#!/bin/bash

echo "Here I am" >> /home/server/logs
```

To enable executing system daemon, we need to execute: `systemctl start logger-exam.timer` (in this example).

### Modification in Java app to enable healthcheck endpoint

We need to add separate controller class to represent our __/healthcheck__ endpoint:

```Java
package com.pazyniuk.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class HealthController {
  
  @RequestMapping(value = "/healthcheck", method = RequestMethod.GET)
  public ResponseEntity returnHealthCheckResponse() {
      return new ResponseEntity<>("Everything is OK", HttpStatus.OK);
  }
}
```

Reference [here](https://github.com/damoklov/spring-jpa-iot/blob/docker-one-container/src/main/java/com/pazyniuk/controller/HealthController.java).

### Include healthcheck option to docker-compose

We need to add __healthcheck__ position to our docker-compose.yml file:
```Dockerfile
healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/healthcheck"]
      interval: 30s
      timeout: 15s
      retries: 5
      start_period: 60s
```

Later, we are able to run `docker inspect <container-id>` to check health of our container.

### Docker container

To run Java application and MySQL service in one container I used Ubuntu 18.04 image and modified my [Dockerfile](https://github.com/damoklov/operation-systems/blob/master/docker-compose-exam/Dockerfile).

Also, you can find my wrapper script and docker-compose files [here](https://github.com/damoklov/operation-systems/tree/master/docker-compose-exam).

To run a container: `docker-compose build --no-cache` and `docker-compose up`.

To connect to shell of the container: `docker exec -it <container-id> /bin/bash`.

To copy file from container to host: `docker cp <containerId>:/file/path/within/container /host/path/target`.

### Helpful articles

[Systemd timer usage](https://opensource.com/article/20/7/systemd-timers)

[Systemd timer time spans](https://www.freedesktop.org/software/systemd/man/systemd.time.html)

[Copying container files thread](https://stackoverflow.com/questions/22049212/docker-copying-files-from-docker-container-to-host)

[Connecting to container via shell](https://phase2.github.io/devtools/common-tasks/ssh-into-a-container/)

[Docker healthcheck article (RU)](https://dotsandbrackets.com/docker-health-check-ru/)

[SSH key-only connection (RU)](https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server-ru)

[Dockerfile healthcheck docs](https://docs.docker.com/engine/reference/builder/#healthcheck)

[Docker-compose docs](https://docs.docker.com/compose/compose-file/compose-file-v3/)

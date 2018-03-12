#!/bin/sh
docker run -p 8080:8080 -p 8877:8877 -d -it --cap-add=SYS_PTRACE --security-opt=apparmor:unconfined --name art-decor art-decor

# Or, if you've already created the container:
# docker start art-decor

#!/bin/bash

podman build -t openthread .
podman run --rm -it --privileged --group-add keep-groups --name openthread --device /dev/ttyACM0 openthread bash
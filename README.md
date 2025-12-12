# Openthread ESP32 firmare builder

This project implements the build environment for the following incomplete and inaccurate guide:

https://openthread.io/guides/border-router/espressif-esp32

## Howto

Briefly:

1) Buy an [ESP Thread Border Router](https://www.digikey.com.au/en/products/detail/espressif-systems/ESP-THREAD-BR-ZIGBEE-GW/21292142) Board.
2) Connect it to your computer, find out which device it enumerates as. Mine was `/dev/ttyACM0`.
2) Install podman, run go.sh to build and launch the container. The same would probably work for docker with slight tweaks.
3) Once you have a shell inside the container, run `idf.py menuconfig` and set up WiFi and enable the Thread Border Router and webserver. Save the config.
4) Then run `idf.py -p /dev/ttyACM0 flash monitor'`

Then tweak, reboot, fume and twiddle until it's all running. Integrating to Home Assistant involves both the "Thread" and "Open Thread Border Router" integrations. You also need to run a matter server separately and integrate it via the "Matter" integration. You can run the Matter server as a HASS "addon" (distinct from an integration), but I ran it as a [separate docker container](https://community.home-assistant.io/t/using-matter-and-thread-in-a-dockerized-ha-instance/721088/7?u=msly). It's a real mess. Best of luck.

## Other links

https://www.matteralpha.com/how-to/how-to-build-a-thread-1-4-border-router
https://github.com/espressif/esp-thread-br
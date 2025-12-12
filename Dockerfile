FROM ubuntu

RUN apt-get update && apt-get install -y git python3 python3-pip python3-venv libusb-1.0-0 cmake

RUN git clone -b v5.4.2 --recursive https://github.com/espressif/esp-idf.git
RUN git clone -b v1.2 --recursive https://github.com/espressif/esp-thread-br.git

RUN cd esp-idf; ./install.sh


RUN bash -c '. /esp-idf/export.sh && \
cd /esp-idf/examples/openthread/ot_rcp && \
idf.py set-target esp32h2 && \
idf.py build'

RUN bash -c '. /esp-idf/export.sh && \
cd /esp-thread-br/examples/basic_thread_border_router && \
idf.py set-target esp32s3'

WORKDIR /esp-thread-br/examples/basic_thread_border_router

COPY entrypoint.sh /entrypoint.sh

RUN echo 'ls -la /dev/ttyACM0' > /root/.bash_history
RUN echo 'idf.py menuconfig' >> /root/.bash_history
RUN echo 'idf.py -p /dev/ttyACM0 flash monitor' >> /root/.bash_history

ENTRYPOINT [ "/entrypoint.sh" ]
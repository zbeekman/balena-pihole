FROM balenalib/raspberrypi3-debian:jessie-build AS build

WORKDIR /usr/src

RUN install_packages python

RUN git clone https://github.com/xorbit/LiFePO4wered-Pi.git .
RUN chmod +x build.py ; ./build.py
RUN sed -i '/^ *# [Cc]heck/,$d' INSTALL.sh ; chmod +x INSTALL.sh
RUN ./INSTALL.sh

FROM balenalib/raspberrypi3-debian:jessie-run

WORKDIR /usr/src

COPY --from=build /usr/local/lib/liblifepo4wered.so /usr/local/lib/
COPY --from=build /usr/local/bin/lifepo4wered-cli /usr/local/bin/
COPY --from=build /usr/local/sbin/lifepo4wered-daemon /usr/local/sbin/
COPY --from=build /etc/init.d/lifepo4wered-daemon /etc/init.d/

RUN echo "" >> /etc/modules ; \
    echo "# Load I2C device module" >> /etc/modules ; \
    echo "i2c-dev" >> /etc/modules

RUN ls -l /usr/local/bin/lifepo4wered-cli /usr/local/sbin/lifepo4wered-daemon /usr/local/lib/liblifepo4wered.so /etc/init.d/lifepo4wered-daemon

COPY ensure-ups.sh /usr/bin/

CMD modprobe i2c-dev && /usr/bin/ensure-ups.sh

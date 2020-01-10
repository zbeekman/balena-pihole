FROM balenalib/raspberrypi3-debian:jessie-build AS build

WORKDIR /usr/src

RUN install_packages python libraspberrypi-dev tree

RUN git clone https://github.com/xorbit/LiFePO4wered-Pi.git .
RUN chmod +x build.py ; ./build.py
RUN sed -i '/^ *# [Cc]heck/,$d' INSTALL.sh ; chmod +x INSTALL.sh ; cat INSTALL.sh
RUN tree
RUN ./INSTALL.sh

FROM balenalib/raspberrypi3-debian:jessie-run

WORKDIR /usr/src

COPY --from=build /usr/local/lib/liblifepo4wered.so /usr/local/lib/
COPY --from=build /usr/local/bin/lifepo4wered-cli /usr/local/bin/
COPY --from=build /usr/local/sbin/lifepo4wered-daemon /usr/local/sbin/
COPY --from=build /etc/init.d/lifepo4wered-daemon /etc/init.d/

RUN update-rc.d lifepo4wered-daemon defaults
RUN service lifepo4wered-daemon status

RUN lifepo4wered-cli || true
RUN ls -l /usr/local/bin/lifepo4wered-cli /usr/local/sbin/lifepo4wered-daemon /usr/local/lib/liblifepo4wered.so /etc/init.d/lifepo4wered-daemon
RUN cat /etc/init.d/lifepo4wered-daemon

COPY ensure-ups.sh /usr/bin/

CMD ["/usr/bin/ensure-ups.sh"]

FROM balenalib/raspberrypi3-debian:jessie-build AS build

WORKDIR /usr/src

RUN install_packages python libraspberrypi-dev tree

RUN git clone https://github.com/xorbit/LiFePO4wered-Pi.git .
RUN chmod +x build.py ; ./build.py
RUN sed -i -e '/^ *# [Cc]heck/,$d' -e 's/build\//.\//g' INSTALL.sh ; chmod +x INSTALL.sh ; cat INSTALL.sh
RUN tree

FROM balenalib/raspberrypi3-debian:jessie-run

WORKDIR /usr/src

COPY --from=build /usr/src/* /usr/src/
RUN ls -la
RUN install_packages tree
RUN tree .
RUN cat ./INSTALL.sh ; ./INSTALL.sh
RUN lifepo4wered-cli set auto_boot 1 ; lifepo4wered-cli set cfg_write 0x46
RUN ls -la .

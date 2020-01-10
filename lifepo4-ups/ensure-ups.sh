#!/bin/sh

update-rc.d lifepo4wered-daemon defaults
service lifepo4wered-daemon restart
lifepo4wered-cli set auto_boot 1 # Auto-boot whenever there is power to do so
lifepo4wered-cli set cfg_write 0x46 # Save this setting
echo "Current battery voltage in mV:"
lifepo4wered-cli get vbat

#!/usr/bin/env/ bash
# Don't run the daemon in the background because the shell will exit.

service lifepo4wered-daemon status
update-rc.d lifepo4wered-daemon defaults
lifepo4wered-cli set auto_boot 1 # Auto-boot whenever there is power to do so
lifepo4wered-cli set cfg_write 0x46 # Save this setting
echo "Current battery voltage in mV:"
lifepo4wered-cli get vbat
#service lifepo4wered-daemon restart
bash -x /etc/init.d/lifepo4wered-daemon restart
#!/usr/bin/env bash
# Run the daemon in the background but enter an infinite loop to report the status

update-rc.d lifepo4wered-daemon defaults
service lifepo4wered-daemon status

lifepo4wered-cli set auto_boot 1 # Auto-boot whenever there is power to do so
lifepo4wered-cli set cfg_write 0x46 # Save this setting
echo "All UPS settings:"
lifepo4wered-cli get
echo "Current battery voltage in mV:"
lifepo4wered-cli get vbat
service lifepo4wered-daemon status
service lifepo4wered-daemon restart
#bash -x /etc/init.d/lifepo4wered-daemon restart
service lifepo4wered-daemon status

while true ; do
    sleep "${LIFEPO4_REPORT_INTERVAL:-600}"
    echo "Current battery voltage in mV:"
    lifepo4wered-cli get vbat
    service lifepo4wered-daemon status
done

# ffp-update-location-gpsd

This package configures gluon to update the location based on NMEA output of a local GPS daemon.

This package is dependent on gpsd and gpsd-clients, which will be also installed.
The configuration of the GPSd should be done manually in /etc/config/gpsd.

The location is only updated in memory - and only if a valid GPS fix is available.
After a reboot, the old location from the config is set.


## further information

Further information can be found here:

* https://github.com/dmth/gluon-gps-locationupdate
* https://forum.freifunk.net/t/freifunk-location-update-via-gps/1493

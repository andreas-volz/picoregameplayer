#!/bin/sh

export LOG=/var/log/jivelite.log

if [ -f /usr/local/sbin/config.cfg ]; then
    source /usr/local/sbin/config.cfg
fi

# Disable mouse pointer
export JIVE_NOCURSOR=1
# Set touch calibration file
TSLIB_CALIBFILE=/usr/local/etc/pointercal
# Jivelite interface framerate
#export JIVE_FRAMERATE=22
# Set 32bit color 
#/usr/sbin/fbset -depth 32

# Set Touch input device 
export TSLIB_TSDEVICE=/dev/input/event0 # This might be event1 in some cases
export SDL_MOUSEDRV=TSLIB

# Define custom JogglerSkin/Grid Skin size
# The default 1920x1080 skin is too small - scale to 853x480. This could be any size to scale interface.
export JL_SCREEN_WIDTH=1024
export JL_SCREEN_HEIGHT=600

# Set custom screen resolution
/usr/sbin/fbset -xres 1024 -yres 600

# load IR data
ir-keytable -p all -c
ir-keytable -c -w /usr/local/etc/keytables/jivelite

# temporary while development - remove for release!
ln -s /mnt/mmcblk0p2/tce/src/GamePlayer/ /opt/jivelite/share/jive/applets/

export HOME=/home/tc

jivecode ()
{
  JRET=`cat /tmp/jivelite_return`
  echo JRET: $JRET
  return $JRET
}

# Run Jivelite or Emulator
echo "0" > /tmp/jivelite_return
JIVELITE_RETURN="0"

while true; do

  if [ "$JIVELITE_RETURN" == "42" ]; then
       echo "run emulator..."
       cd /mnt/mmcblk0p2/tce/emulator
       ./run.sh
       echo "0" > /tmp/jivelite_return
       JIVELITE_RETURN=0
  else
       /opt/jivelite/bin/jivelite >> /var/log/jivelite.log 2>&1
       jivecode
       JIVELITE_RETURN=$?
       echo JIVELITE_RETURN $JIVELITE_RETURN
  fi

#    sleep 3

done

#!/bin/sh

if [ -e usertorrc ]; then
  echo "Found user torrc configuration. Applying it..."
  cat usertorrc >> /tmp/torrc
fi

PASSWORD_APPLIED=$(grep HashedControlPassword /tmp/torrc -c)

if [ -e userscript.sh ]; then
  echo "Found userscript. Applying it..."
  /bin/sh userscript.sh
fi

if [ ! -z "$EXIT_NODES" ]; then
  "Found EXIT_NODES environment variable. Applying it..."
  echo "ExitNodes $EXIT_NODES" >> /tmp/torrc
fi

if [ ! -z "$COUNTRY" ]; then
  "Found COUNTRY environment variable. Applying it as exit node..."
  echo "ExitNodes {$COUNTRY}" >> /tmp/torrc
fi

if [ $PASSWORD_APPLIED -eq "0" ]; then

  echo "HashedControlPassword" `/usr/bin/tor --hash-password $PASSWORD` >> /tmp/torrc
fi

echo "Resulting torrc config file:"
cat /tmp/torrc

tor -f /tmp/torrc

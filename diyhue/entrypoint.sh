#!/bin/sh
set -e

DEVICE_INFO=$(curl -s -X GET --header "Content-Type:application/json" "$BALENA_SUPERVISOR_ADDRESS/v1/device?apikey=$BALENA_SUPERVISOR_API_KEY")
IP=$(echo $DEVICE_INFO | jq -r '.ip_address')
MAC=$(echo $DEVICE_INFO | jq -r '.mac_address' | awk '{print $1}')

if [ -f "/opt/hue-emulator/export/cert.pem" ]; then
    echo "Restoring certificate"
    cp /opt/hue-emulator/export/cert.pem /opt/hue-emulator/cert.pem
elif [ -f "/opt/hue-emulator/cert.pem" ]; then
    echo "Exporting certificate"
    cp /opt/hue-emulator/cert.pem /opt/hue-emulator/export/cert.pem
fi

if [ -f "/opt/hue-emulator/export/config.json" ]; then
    echo "Restoring config" 
    cp /opt/hue-emulator/export/config.json /opt/hue-emulator/config.json
fi

exec "$@" --docker --ip=$IP --mac=$MAC

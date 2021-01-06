#!/bin/sh
set -e

if [ ! -z "$ZIGBEE2MQTT_DATA" ]; then
    DATA="$ZIGBEE2MQTT_DATA"
else
    DATA="/app/data"
    if [ -d /persistent ]; then
        mkdir -p /persistent/zigbee2mqtt
        rm -rf $DATA && ln -sf /persistent/zigbee2mqtt $DATA 
    fi
fi

echo "Using '$DATA' as data directory"

if [ ! -f "$DATA/configuration.yaml" ]; then
    echo "Creating configuration file..."
    cp /app/configuration.yaml "$DATA/configuration.yaml"
fi

exec "$@"
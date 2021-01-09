#!/bin/sh
set -e

DEVICE_INFO=$(curl -s -X GET --header "Content-Type:application/json" "$BALENA_SUPERVISOR_ADDRESS/v1/device?apikey=$BALENA_SUPERVISOR_API_KEY")
IP=$(echo $DEVICE_INFO | jq -r '.ip_address')
MAC=$(echo $DEVICE_INFO | jq -r '.mac_address' | awk '{print $1}')

exec "$@" --docker --ip=$IP --mac=$MAC

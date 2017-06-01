#!/usr/bin/env bash
IP_ADDRESS=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"`
echo  $IP_ADDRESS "  " "$@" 
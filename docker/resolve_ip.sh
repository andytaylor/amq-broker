#!/usr/bin/env bash
IP_ADDRESS=`docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$@"`
echo  $IP_ADDRESS "  " "$@"
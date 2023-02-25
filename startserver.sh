#!/bin/bash

echo "Starting server as user: $USER"

screen -dmS minecraftserver bash -c "cd /opt/mcserver/;java -Xms256M -Xmx2G -jar server.jar nogui"

echo "Done."

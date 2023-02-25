#!/bin/bash

function find_screen {
        if screen -ls "$1" | grep -o "minecraftserver">>/dev/null; then
                screen -ls "$1" | grep -o "minecraftserver">>/dev/null
                return 0
        else
                echo "$1"
                return 1
        fi
}


if find_screen "minecraftserver" >/dev/null; then

        echo "Found the minecraftserver screen. Shutting down server if still running."

        screen -S minecraftserver -X stuff 'stop'`echo -ne '\015'`

        sleep 10

        # Shutting down screen if it hasn't shut down already

        screen -wipe >/dev/null

else

        echo "Cleaning up our screens, something went horrifically wrong."

        for scr in $(screen -ls | awk '{print $1}'); do screen -S $scr -X kill; done

fi

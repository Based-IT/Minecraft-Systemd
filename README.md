# Minecraft-Systemd
Scripts and associated files to startup a Minecraft server with systemd


## Usage:

1. Create a non-sudoers user account named mcserver.

2. Create the directory `/opt/mcserver/` as mcserver.

3. Install a Minecraft server in the directory `/opt/mcserver/` as the mcserver user. Rename the server jar file to server.jar. Once configured, make sure the server is stopped. <br>
  Just to reiterate - make sure this is done as mcserver. The directory should look like this:
  
``` sh 
$ ls -l /opt/mcserver/
total 38356
-rw-rw-r--  1 mcserver mcserver      157 Feb 25 14:38 eula.txt
-rw-rw-r--  1 mcserver mcserver 39174430 Feb 25 14:31 server.jar
-rw-rw-r--  1 mcserver mcserver     1307 Feb 25 17:58 server.properties
...
```

4. Add startserver.sh and stopserver.sh into the `/opt/mcserver/` directory

``` sh
$ ls -l /opt/mcserver/
total 38356
-rw-rw-r--  1 mcserver mcserver      157 Feb 25 14:38 eula.txt
-rw-rw-r--  1 mcserver mcserver 39174430 Feb 25 14:31 server.jar
-rw-rw-r--  1 mcserver mcserver     1307 Feb 25 17:58 server.properties
-rwxrwxr-x  1 mcserver mcserver      188 Feb 25 17:48 startserver.sh
-rwxrwxr-x  1 mcserver mcserver      619 Feb 25 17:17 stopserver.sh
...
```

Make sure both shell scripts are executable.


> NOTE: Inside of startserver.sh, you'll be able to edit your java parameters.


5. As root, place the minecraftserver.service file into the /etc/systemd/system/ directory.
``` sh
$ ls -l /etc/systemd/system/
total 168
-rw-r--r-- 1 root root  323 Feb 25 17:39  minecraftserver.service
...
```

6. You will need to edit systemd to not kill processes spawned by the mcserver user. To do so, follow these steps:
  - edit /etc/systemd/logind.conf
  
  ``` sh
 $ vi /etc/systemd/logind.conf

  ```
  - uncomment the line "KillExcludeUsers" under {Login}

``` conf
[Login]
#NAutoVTs=6
#ReserveVT=6
#KillUserProcesses=no
#KillOnlyUsers=
KillExcludeUsers=root
...
```
  
  - add the user mcserver

``` conf
[Login]
#NAutoVTs=6
#ReserveVT=6
#KillUserProcesses=no
#KillOnlyUsers=
KillExcludeUsers=root mcserver
...
```

  - reset systemd
  
  `$ systemctl daemon-reload`
  
7. Start the minecraftserver service

  `$ systemctl start minecraftserver`
  
  And to automatically start the server on boot, run:
  
  `$ systemctl enable minecraftserver`
  
  And to manually stop the server, run:
  
  `$ systemctl stop minecraftserver`
  
8. You're done. Congrats.




# Server Interaction

In order to interact with the server, you'll need to launch a terminal as the mcserver user. <br>
From there, type:

`$ screen -r` -- or launch the screen named mineraftserver if you have other screens active

To end interaction with the server, use the screen keyboard shortcut `Ctrl+a+d` or `Ctrl+d+a`.

For remote interaction with the server, I recommend setting up SSH access only for the mcserver user account (do not enable ssh login as root). Use a random port, and a very strong password as it will be attacked by internet sweeps. If you don't know what you're doing, use a friendlier solution like TeamViewer.

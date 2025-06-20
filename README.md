## Why?
My Bose QC Ultra does not automatically connect to my PC running Bazzite or Arch. The issue is that the Bose headset needs to be connected using BR/EDR (Basic Rate/Enhanced Data Rate) and not in dual mode. However, if I set the controller mode to BR/EDR, other devices do not connect.

The solution is to run a bash script that detects when the Bose headset is connecting and sets the mode to BR/EDR only. If another device is connecting, the script switches the mode back to dual (i.e., enables LE).

I know this is a very janky workaround, but it's the only way I've been able to get it working so far
<br/>
<br/>
### Create a file for the the bash scriptr
```
sudo vim /usr/local/bin/bt_mode_shell.sh
```
Copy the content from the file with the same name and replase the MAC address with your headset MAC
<br/>
### Create a service file
```
sudo nano /etc/systemd/system/bt-mode-monitor.service
```
Copy the content from the file with the same name 
<br/>
### Init the service
```
sudo systemctl enable --now bt-mode-monitor.service
```
### For debug Debug
```
journalctl -u bt-mode-monitor -f
```
### Bluez-utils
It needs to be set as version 82. You can run btmgt commands on version 83.1.

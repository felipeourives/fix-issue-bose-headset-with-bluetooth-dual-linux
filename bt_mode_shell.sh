#!/bin/bash
HEADSET_MAC="66:66:66:66:66:66"  # Change to your headset's MAC

dbus-monitor --system "type='signal', member='PropertiesChanged'" | while read -r line; do
    echo "Running"
    # Extract the MAC from path
    if [[ "$line" =~ /hci[0-9]/dev_([0-9A-Fa-f_]+) ]]; then
        
	CURRENT_MAC=$(echo "${BASH_REMATCH[1]}" | tr '_' ':')
        CONNECTED="false"
        echo "Connected"

        # Read next 10 lines to find connection status
        for _ in {1..10}; do
            read -r next_line
            if [[ "$next_line" =~ "boolean true" ]]; then
                CONNECTED="true"
                break
            elif [[ "$next_line" =~ "boolean false" ]]; then
                break
            fi
        done
        
        if [[ "$CONNECTED" == "true" ]]; then
            echo "Device connected: $CURRENT_MAC"
            
            if [[ "$CURRENT_MAC" == "$HEADSET_MAC" ]]; then
                echo "Switching to BR/EDR mode"
                sudo btmgmt bredr on
                sudo btmgmt le off
            else
                echo "Keeping DUAL mode"
                sudo btmgmt dual on
            fi
            sudo btmgmt power on
        fi 
    fi
done

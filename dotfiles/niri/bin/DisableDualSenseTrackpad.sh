#!/bin/sh
# Disable PS5 DualSense trackpad - runs continuously to catch device when connected

# Function to disable the trackpad
disable_trackpad() {
	xinput list | grep -i "dualsense.*touchpad\|sony.*dualsense.*touchpad" | while read line; do
		id=$(echo "$line" | grep -o 'id=[0-9]*' | grep -o '[0-9]*')
		if [ -n "$id" ]; then
			# Check if currently enabled
			enabled=$(xinput list-props "$id" 2>/dev/null | grep "Device Enabled" | grep -o '[01]$')
			if [ "$enabled" = "1" ]; then
				xinput disable "$id" 2>/dev/null
				logger -t "dualsense-trackpad" "Disabled trackpad device id=$id"
			fi
		fi
	done
}

# Initial attempt after X is ready
(sleep 3 && disable_trackpad) &

# Keep checking periodically in case controller connects after startup
(
	while true; do
		sleep 5
		disable_trackpad
	done
) &

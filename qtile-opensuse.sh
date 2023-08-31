#!/bin/bash

# Update repositories
sudo zypper refresh
sudo zypper update -y

# Install required packages
sudo zypper install -y qtile rofi kitty vivaldi skypeforlinux

# Install rofi-power-menu
git clone https://github.com/jluttine/rofi-power-menu.git
sudo mv rofi-power-menu/rofi-power-menu /usr/local/bin/
rm -rf rofi-power-menu

# Enable and start NetworkManager service
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

# Create qtile config directory
mkdir -p ~/.config/qtile

# Customize the qtile config (replace with your preferences)
echo '
from libqtile import bar, layout, widget, hook
from typing import List  # noqa: F401
import os

mod = "mod4"  # Use the Super key as the mod key

# Define workspaces
workspaces = [
    {"name": "1:term", "key": "1", "matches": [Match(wm_class=["kitty"])]},
    {"name": "2:browser", "key": "2", "matches": [Match(wm_class=["Vivaldi-stable"])]},
    {"name": "3:skype", "key": "3", "matches": [Match(wm_class=["Skype"])]},
]

# ...

# Configure bar
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Wlan(interface="wlan0"),
                widget.CPU(format="CPU: {load_percent}%"),
                widget.Memory(format="Mem: {MemUsed}M/{MemTotal}M"),
                widget.ThermalSensor(tag_sensor="coretemp_package_id_0"),
                widget.DF(partition="/home", format="/home: {uf}B"),
                widget.Volume(),
                widget.Battery(format="{char} {percent:2.0%}"),
                widget.Systray(),
            ],
            24,  # Bar height
        ),
    ),
]

# ...

' > ~/.config/qtile/config.py

# Start qtile
exec qtile


#!/bin/bash
if [[ -z "$1" || "$1" != "-nopwd" ]]; then
 echo 10210813 | sudo -S sh -c 'echo "$(($(cat /sys/class/backlight/intel_backlight/brightness)+500))"|sudo tee /sys/class/backlight/intel_backlight/brightness>/dev/null 2>&1'
else
 echo "$(($(cat /sys/class/backlight/intel_backlight/brightness)+500))"|sudo tee /sys/class/backlight/intel_backlight/brightness>/dev/null
fi

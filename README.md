# swaywait
Tool for waiting window appearing on the screen in autostart scripts. Extendend and fixed version of provided [here](https://gitlab.com/wef/dotfiles/-/blob/master/bin/i3-toolwait)

# Example of usage
```shell
#!/usr/bin/env bash

notify-send --expire-time=3000 \
            --icon=dialog-info \
            --urgency=critical \
            --app-name "" \
            "Startup initialization" "Starting of predefined windows began"

swaymsg "workspace number 12"
swaywait --required-instance emacs -- gtk-launch emacsclient
swaymsg "workspace number 11"
swaywait --required-instance emacs -- gtk-launch emacsclient
swaymsg "workspace number 10"
swaywait --required-instance emacs -- gtk-launch emacsclient
swaymsg "workspace number 9"
swaywait --required-instance emacs -- gtk-launch emacsclient

swaymsg assign [instance="goldendict"] workspace number 8
swaymsg "workspace number 8"
swaywait --required-instance goldendict -- goldendict

swaymsg "workspace number 7"
swaywait --required-app-id deadbeef -- gtk-launch deadbeef

swaymsg "workspace number 5"
swaywait --required-app-id org.telegram.desktop -- flatpak run org.telegram.desktop

swaymsg "workspace number 3"
swaywait --required-instance emacs -- gtk-launch emacsclient
swaymsg "workspace number 2"
swaywait --required-instance emacs -- gtk-launch emacsclient

swaymsg "workspace number 1"
swaywait --required-app-id firefox -- gtk-launch firefox

notify-send --expire-time=3000 \
            --icon=dialog-info \
            --urgency=critical \
            --app-name "" \
            "Startup initialization" "Everything started"
```

## About

Kanata is a keyboard remapping tool for macOS that allows you to customize your keyboard layout and create custom key bindings.

## Making changes

View documentation for Kanata at https://jtroo.github.io/config.html

After making a change to the kanata.kbd file, run the following commands to load the new config:
- `sudo launchctl stop com.example.kanata`
- `sudo launchctl start com.example.kanata`

## Setup
View logs with this command: `sudo tail -f /Library/Logs/Kanata/kanata.err.log`

Start the kanata daemon with this command: `sudo launchctl load /Library/LaunchDaemons/com.example.kanata.plist`

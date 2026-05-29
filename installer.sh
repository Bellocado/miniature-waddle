cat << 'EOF' >> ~/.config/sway/config

### BAR FRAMEWORK ###
bar {
    position top
    status_command while true; do echo "VOL: $(amixer sget Master | awk -F'[][]' '/Left:/ { print $2 }') │ WIFI: $(nmcli -t -f active,ssid dev wifi | grep yes | cut -d: -f2) │ BAT: $(acpi | awk '{print $4}' | tr -d ',') │ $(date +'%Y-%m-%d │ %H:%M')"; sleep 1; done
    colors {
        statusline #ffffff
        background #24273a
        focused_workspace  #5c5c5c #5c5c5c #ffffff
        inactive_workspace #231f20 #231f20 #aaaaaa
    }
}
EOF

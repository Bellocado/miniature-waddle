# 1. Create all needed configuration directories
mkdir -p ~/.config/sway ~/.config/foot ~/.config/yofi ~/.config/mako ~/.config/waybar

# 2. Deploy Foot Terminal Config (Catppuccin Macchiato)
cat << 'EOF' > ~/.config/foot/foot.ini
[main]
font=monospace:size=11
[cursor]
style=beam
blink=yes
[colors-dark]
foreground=cad3f5
background=24273a
regular0=494d64
regular1=ed8796
regular2=a6da95
regular3=eed49f
regular4=8aadf4
regular5=f5bde6
regular6=8bd5ca
regular7=b8c0e0
EOF

# 3. Deploy Mako Notification Config (Catppuccin Mocha)
cat << 'EOF' > ~/.config/mako/config
font=sans-serif 10
width=300
height=110
margin=10
padding=15
border-size=2
border-radius=5
default-timeout=5000
background-color=#1e1e2e
text-color=#cdd6f4
border-color=#cba6f7
EOF

# 4. Deploy Yofi Launcher Config
cat << 'EOF' > ~/.config/yofi/yofi.conf
width = 450  
height = 300
corner_radius = "6"
font_size = 18
bg_color = 0x24273aee
bg_border_color = 0x8aadf4ff
bg_border_width = 2.0
font_color = 0xcad3f5ff
term = "foot"
[input_text]
font_color = 0xcad3f5ff
bg_color = 0x36394fff
[list_items]
font_color = 0xcad3f5ff
selected_font_color = 0xed8796ff
match_color = 0xeed49fff
margin = "5 10"
EOF

# 5. Deploy Waybar Config (Clean top panel)
cat << 'EOF' > ~/.config/waybar/config
[{
    "layer": "top",
    "position": "top",
    "height": 30,
    "modules-left": ["sway/workspaces", "sway/mode"],
    "modules-center": ["clock"],
    "modules-right": ["battery", "network"],
    "clock": { "format": "{:%H:%M │ %Y-%m-%d}" },
    "battery": { "format": "⚡ {capacity}%" },
    "network": { "format-wifi": " {essid}", "format-ethernet": "🔌 Eth" }
}]
EOF

# 6. Deploy Waybar CSS Styling
cat << 'EOF' > ~/.config/waybar/style.css
* { font-family: sans-serif; font-size: 13px; border: none; border-radius: 0; }
window#waybar { background-color: #24273a; color: #cad3f5; }
#workspaces button { padding: 0 10px; color: #a5adcb; }
#workspaces button.focused { color: #8aadf4; border-bottom: 2px solid #8aadf4; }
#clock, #battery, #network { padding: 0 15px; color: #cad3f5; }
EOF

# 7. Deploy Main Sway Config
cat << 'EOF' > ~/.config/sway/config
set $mod Mod4
set $terminal foot

# Target your multilingual setup
input * {
    xkb_layout "us,si,de"
    xkb_options "grp:win_space_toggle"
}
input type:touchpad {
    tap enabled
    natural_scroll enabled
}

# Aesthetic adjustments
gaps inner 8
gaps outer 4
default_border pixel 2
default_floating_border pixel 2

client.focused          #8aadf4 #24273a #cad3f5 #8aadf4 #8aadf4
client.focused_inactive #494d64 #24273a #b8c0e0 #494d64 #494d64
client.unfocused        #36394f #24273a #a5adcb #36394f #36394f

# Bindings
bindsym $mod+Return exec $terminal
bindsym $mod+q kill
bindsym $mod+Shift+e exec swaynag -t warning -m 'Exit sway?' -b 'Yes' 'swaymsg exit'
bindsym --release Super_L exec pkill yofi || yofi

# Workspaces
bindsym $mod+1 workspace number 1
bindsym $mod+2 workspace number 2
bindsym $mod+3 workspace number 3
bindsym $mod+4 workspace number 4
bindsym $mod+5 workspace number 5
bindsym $mod+Shift+1 move container to workspace number 1
bindsym $mod+Shift+2 move container to workspace number 2
bindsym $mod+Shift+3 move container to workspace number 3
bindsym $mod+Shift+4 move container to workspace number 4
bindsym $mod+Shift+5 move container to workspace number 5

# Autostart Environment Daemons
exec mako
exec waybar
EOF

echo "Configurations successfully applied!"

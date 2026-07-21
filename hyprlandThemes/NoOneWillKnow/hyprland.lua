-- ENVIRONMENT VARIABLES

hl.env("XCURSOR_THEME", "SilkSong-XCursor48x48")
hl.env("XCURSOR_SIZE", 48)

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("WLR_NO_HARDWARE_CURSORS", 1)
hl.env("WLR_RENDERER_ALLOW_SOFTWARE", 1)



--MONITORS


hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1200@60",
    position = "0x1400",
    scale    = 1,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "3840x2160@30",
    position = "-3840x0",
    scale    = 1,
})

--3840x2160

--MY PROGRAMS

local terminal = "kitty -c ~/.config/hyprlandThemes/NoOneWillKnow/kitty/kitty.conf"
local fileManager = "nemo"
local menu = "rofi -theme ~/.config/hyprlandThemes/NoOneWillKnow/rofiThemes/run.rasi -show drun -display-drun Start"

-- STARTUUP



-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("zsh -c 'waybar -c ~/.config/hyprlandThemes/NoOneWillKnow/waybar/config.jsonc -s ~/.config/hyprlandThemes/NoOneWillKnow/waybar/style.css'")
    hl.exec_cmd("hypridle & hyprpaper -c ~/.config/hyprlandThemes/NoOneWillKnow/hypr/hyprpaper.conf & hyprlock -c ~/.config/hyprlandThemes/NoOneWillKnow/hypr/hyprlock.conf && zsh -c 'kitty +kitten panel --config=~/.config/kitty/kittyl.conf --edge=background -o background_opacity=0 -o background=black zsh -c printf \\\"\\n\\n\\n\\\"; hyfetch; printf \\\"\\e[?25l\\\"; sleep infinity ' && powerprofilesctl set power-saver")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("[workspace 1 silent] discord --enable-features=UseOzonePlatform --ozone-platform=wayland")
    hl.exec_cmd("[workspace 2 silent] firefox")
    hl.exec_cmd("hyprctl setcursor Silk-Cursor 48")
end)

-- Exec (run every reload)
hl.on("config.reloaded", function()
    hl.exec_cmd("killall hyprpaper; hyprpaper -c ~/.config/hyprlandThemes/NoOneWillKnow/hypr/hyprpaper.conf & zsh -c 'kitty +kitten panel --config=~/.config/kitty/kittyl.conf --edge=background -o background_opacity=0 -o background=black zsh -c printf \\\"\\n\\n\\n\\\"; hyfetch; printf \\\"\\e[?25l\\\"; sleep infinity ' && powerprofilesctl set power-saver")
    hl.exec_cmd("killall cava rawtobar.sh waybar ; waybar -c ~/.config/hyprlandThemes/NoOneWillKnow/waybar/config.jsonc -s ~/.config/hyprlandThemes/NoOneWillKnow/waybar/style.css" )
    hl.exec_cmd("ln -sfn ~/.config/hyprlandThemes/NoOneWillKnow/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc && ln -sfn ~/.config/hyprlandThemes/NoOneWillKnow/hyfetch/hyfetch.json ~/.config/hyfetch.json")
end)




--LOOK AND FEEL



hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        resize_on_border = true, 
        allow_tearing = false,
        layout = "dwindle",
        col = {
            active_border = { colors = { "rgba(74deffaa)", "rgba(ffe1edff)", "rgba(ffb5d6ff)", "rgba(ff8cbfff)", "rgba(ffb5d6ff)", "rgba(ffe1edff)", "rgba(74deffaa)" }, angle = 0 },
            inactive_border = "rgba(595959aa)",
        },
    },
})


hl.config({
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.95,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
})


hl.config({
    animations = {
        enabled = true,
    },
})


hl.config({
    dwindle = {
        preserve_split = true,
    },
})


hl.config({
    master = {
        new_status = "master",
    },
})


hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = false,
    },
})

--Keyboard and devices

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
})

hl.config({
    input = {
        kb_layout = "us,fr",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        -- -1.0 - 1.0, 0 means no modification.
        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.device({
    name = "hp-omen-photon-2",
    sensitivity = -0.1,
})

--##################

--## KEYBINDINGS ###

--##################

local mainMod = "SUPER"


hl.bind(mainMod .. " + " .. "Q", hl.dsp.exec_cmd("kitty -c ~/.config/hyprlandThemes/NoOneWillKnow/kitty/kitty.conf zsh -c 'hyfetch;exec zsh'"))
hl.bind(mainMod .. " + " .. "B", hl.dsp.exec_cmd("~/.config/hyprlandThemes/NoOneWillKnow/scripts/background.sh"))
hl.bind(mainMod .. " + " .. "H", hl.dsp.exec_cmd("~/.config/hyprlandThemes/NoOneWillKnow/scripts/themes.sh"))
hl.bind(mainMod .. " + " .. "T", hl.dsp.exec_cmd("kitty zsh"))
hl.bind(mainMod .. " + " .. "W", hl.dsp.exec_cmd("(killall waybar && killall rawtobar.sh && killall cava) && waybar -c ~/.config/hyprlandThemes/NoOneWillKnow/waybar/config.jsonc -s ~/.config/hyprlandThemes/NoOneWillKnow/waybar/style.css"))
hl.bind(mainMod .. " + " .. "C", hl.dsp.window.close())
hl.bind(mainMod .. " + " .. "M", hl.dsp.exit())
hl.bind(mainMod .. " + " .. "E", hl.dsp.exec_cmd("nemo"))
hl.bind(mainMod .. " + " .. "V", hl.dsp.window.float())
hl.bind(mainMod .. " + " .. "R", hl.dsp.exec_cmd("rofi -theme ~/.config/hyprlandThemes/NoOneWillKnow/rofiThemes/run.rasi -show drun -display-drun Start"))
hl.bind(mainMod .. " + " .. "P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + " .. "F", hl.dsp.exec_cmd("rofi -theme ~/.config/hyprlandThemes/NoOneWillKnow/rofiThemes/run.rasi -show window -display-window Find"))
hl.bind("SHIFT" .. " + " .. "F1", hl.dsp.exec_cmd("firejail --net=none steam"))

hl.bind(mainMod .. " + " .. "L", hl.dsp.exec_cmd("hyprlock -c ~/.config/hyprlandThemes/NoOneWillKnow/hypr/hyprlock.conf"))

hl.bind("ALT_L" .. " + " .. "SHIFT_L", hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))


-- Move focus wit+33 6 02 10 62 82h mainMod + arrow keys

hl.bind(mainMod .. " + " .. "left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + " .. "right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + " .. "up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + " .. "down", hl.dsp.focus({ direction = "down" }))

--Move windows arount

hl.bind("SUPER + SHIFT" .. " + " .. "left", hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + SHIFT" .. " + " .. "right", hl.dsp.window.swap({ direction = "r" }))
hl.bind("SUPER + SHIFT" .. " + " .. "up", hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + SHIFT" .. " + " .. "down", hl.dsp.window.swap({ direction = "d" }))
hl.bind("SUPER" .. " + " .. "O", hl.dsp.window.fullscreen())

-- Switch workspaces with mainMod + [0-9]

hl.bind(mainMod .. " + " .. 1, hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + " .. 2, hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + " .. 3, hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + " .. 4, hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + " .. 5, hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + " .. 6, hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + " .. 7, hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + " .. 8, hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + " .. 9, hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + " .. 0, hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]

hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 1, hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 2, hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 3, hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + " .. "SHIFT" .." + " .. 4, hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 5, hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 6, hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 7, hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 8, hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 9, hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. 0, hl.dsp.window.move({ workspace = 10 }))

-- Example special workspace (scratchpad)

hl.bind(mainMod .. " + " .. "S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll

hl.bind(mainMod .. " + " .. "mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + " .. "mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging

hl.bind(mainMod .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 4800+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 4800-"), { locked = true })

-- Requires playerctl

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- app shortcuts


-- screenshot of a region 

hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png| dunstify Screenshot of the region taken -t 1000"))
hl.bind(mainMod .. " + " .. "SHIFT" .. " + " .. "P", hl.dsp.exec_cmd("grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png| dunstify Screenshot of whole screen taken -t 1000"))




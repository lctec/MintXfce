apt update


wget -q -O - https://dl.google.com/linux/linux_signing_key.pub |  apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
apt install -y google-chrome-stable

apt install -y htop guake qbittorrent 

############### Conky ################
apt install -y conky-all
cd ~/Descargas
wget https://github.com/circumjacence/ConkyInfinitySVG/archive/master.zip
unzip master.zip
mv ~/Descargas/ConkyInfinitySVG-master/.conky ~/
chmod a+x ~/.conky/startconky.sh

cat <<EOT >> ~/.config/autostart/conky.desktop
[Desktop Entry]
Type=Application
Name=Monitor
Exec=~/.conky/startconky.sh
Icon=
Comment=Monitor de sistema
X-GNOME-Autostart-enabled=true
EOT


cat <<EOT >> ~/.conkyrc
## Conky opciones
background yes
update_interval 1.0

cpu_avg_samples 4
net_avg_samples 2

override_utf8_locale yes

double_buffer yes
no_buffers yes

text_buffer_size 2048

imlib_cache_size 50

## Text settings
use_xft yes
xftfont caviar dreams:size=8
xftalpha 0.5
uppercase no
default_color b7b7b7

## Opciones de ventana

# Opciones de transparencia
own_window yes
own_window_transparent yes
own_window_type dock
own_window_hints undecorated,below,sticky,skip_taskbar,skip_pager
own_window_argb_visual yes
own_window_argb_value 0

## Resolucion y ajuste de ventana

maximum_width 1366
minimum_size 1366 768

#alignment top_left
#alignment top_right
alignment bottom_right

gap_x -70
gap_y -130

border_inner_margin 0
border_outer_margin 0
border_width 0

draw_shades no
draw_outline no
draw_borders no
draw_graph_borders yes

#temperature_unit fahrenheit
temperature_unit celsius

## Lua: Anillos
lua_load ~/.conky/scripts/haunted.lua
lua_draw_hook_pre clock_rings


##########
# Lo que sigue es todo la información y las barras
##########
TEXT
# Reloj
${offset 700}${color EAEAEA}${font GE Inspira:pixelsize=120}${time %H:%M}${font}${voffset -84}${voffset 10}${color FFA300}${font GE Inspira:pixelsize=42}${time %d} ${voffset -15}${color EAEAEA}${font GE Inspira:pixelsize=22}${time %B} ${time %Y}${font}${voffset 124}${font GE Inspira:pixelsize=58}${offset -547}${time %A}${font}
${offset 700}${voffset -100}${font Ubuntu:pixelsize=10}${color FFA300}HD ${offset 9}$color${fs_free /} / ${fs_size /}${offset 30}${color FFA300}RAM ${offset 9}$color$mem / $memmax${offset 30}${color FFA300}CPU ${offset 9}$color${cpu cpu0}%
${voffset 10}${offset 295}${color 2c2c2c}${hr 4}
${image ~/.conky/background.png}


# Disk usage node
${offset 120}${voffset 223}${color 4a89a7}${font Santana:size=8:style=Bold}root$color${font Santana:size=8} : ${offset 16}${fs_used /}/${fs_size /}
${offset 120}${voffset 12}${color 46a646}${font Santana:size=8:style=Bold}home$color${font Santana:size=8} : ${offset 7}${fs_used /home}/${fs_size /home}$font
${offset 120}${voffset 12}${color e83737}${font Santana:size=8:style=Bold}swap$color${font Santana:size=8} : ${offset 10}${swap} / ${swapfree}$font
# "Home" node (kernel, etc.)
${offset 583}${voffset -108}$color${font Santana:size=9:style=Bold}Linux ${kernel} kernel
${offset 585}${voffset 0}${color f4732d}${font Santana:size=8}Uptime : ${offset 9}$color${uptime}
# "User" node (whoami, top process, etc.)
#${offset 833}${voffset -78}$color${font Santana:size=9:style=Bold}${exec whoami}@${nodename}
${offset 833}${voffset -78}$color${font Santana:size=9:style=Bold}debian@luces
${offset 835}${voffset 0}$color${font Santana:size=8}${color 46a646}Top (CPU) : ${offset 9}$color${top name 5} ${top cpu 5}
${offset 835}${voffset 0}$color${font Santana:size=8}${color 46a646}Top (RAM) : ${offset 9}$color${top_mem name 5} ${top_mem mem 5}
${offset 835}${voffset 0}${color 6f6f6f}CPU Usage (${cpu}%) :
${offset 835}${voffset -2}$color${font Santana:size=8}${color 2c2c2c}${cpugraph 32,200 2c2c2c 46a646}
# "Network" node (IP, connections, etc.)
${offset 713}${voffset 88}$color${font Santana:size=9:style=Bold}IP Address : ${addr wlo1}
${offset 715}${voffset 0}$color${font Santana:size=8}TCP Connections : ${tcp_portmon 1 65535 count}
${offset 715}${voffset 0}${font Santana:size=8}${color f4732d}Down : ${offset 9}$color${downspeed wlo1}/s ${offset 8}${color ebff46}Up : ${offset 9}$color${upspeed wlo1} /s
${offset 715}${voffset 0}${color 6f6f6f}${font Santana:size=8}Interface wlo1 Usage :
${offset 715}${voffset -2}$color${font Santana:size=8}${color 2c2c2c}${downspeedgraph wlo1 32,200 b7b7b7 f4732d}
${offset 715}${voffset -5}${color 2c2c2c}${upspeedgraph wlo1 32,200 b7b7b7 ebff46}
# Positioning eset for static text examples below
${voffset -158}
# Static text example: Logo
${offset 120}${color EAEAEA}${font Ubuntu:pixelsize=15}${color f4732d}${exec hostnamectl | grep System | cut -c21-100}$color ${exec hostnamectl | grep Architecture | cut -c7-100}
EOT

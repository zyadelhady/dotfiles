### to Add screenshot to shortcuts 
1 - create file and add 
 
  #!/bin/bash

  maim -s --noopengl | xclip -selection clipboard -t image/png

>>>>

2 - write in terminal 

  sudo chmod +x /path/to/file

>>>>

add the file path to the shortcut 

### for the screenshot with save 
 
#!/bin/bash

maim -s --noopengl > /home/zyad/screenshots/screenshot.$(date +%F.%R:%S).png

>>>>



### install BTOP for TASK MANAGEER 

### install mice for node , npm , go 

### for workspaces 

dconf write /org/gnome/mutter/dynamic-workspaces false
 dconf write /org/gnome/desktop/wm/preferences/num-workspaces 9
 
 dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "['<Super>1']"
 dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "['<Super>2']"
 dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "['<Super>3']"
 dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "['<Super>4']"
 dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-5 "['<Super>5']"
 dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-6 "['<Super>6']"
 dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-7 "['<Super>7']"
 dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-8 "['<Super>8']"
 dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-9 "['<Super>9']"
 
 dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-1  "['<Super><Shift>1']"
 dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-2  "['<Super><Shift>2']"
 dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-3  "['<Super><Shift>3']"
 dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-4  "['<Super><Shift>4']"
 dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-5  "['<Super><Shift>5']"
 dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-6  "['<Super><Shift>6']"
 dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-7  "['<Super><Shift>7']"
 dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-8  "['<Super><Shift>8']"
 dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-9  "['<Super><Shift>9']"
 
 >>>>>

Backup all dconf settings: dconf dump / > settings_backup.dconf

Then create a tarball with that file and a few other directories: tar -zxvf settings_backup.tar.gz settings_backup.dconf .config .local/share/gnome-shell/extensions

You can restore the dconf settings by running this: dconf load / < settings_backup.dconf

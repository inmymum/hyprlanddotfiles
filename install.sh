install() {
    packages=""
    echo "Installing apps and configs"
    if [[ $hypridle ]]; then
      packages+="hypridle "
      echo "-> hypridle"
      curl -s https://raw.githubusercontent.com/inmymum/dotfiles/main/.config/hypr/hypridle.conf | tee /home/$USER/.config/hypr/hypridle.conf > /dev/null
    fi
    if [[ $hyprlock ]]; then
      packages+="hyprlock "
      echo "-> hyprlock"
      curl -s https://raw.githubusercontent.com/inmymum/dotfiles/main/.config/hypr/hyprlock.conf | tee /home/$USER/.config/hypr/hyprlock.conf > /dev/null  
    fi
    if [[ $browser ]]; then
      mkdir /home/$USER/apps
      mkdir /home/$USER/apps/thorium
      echo "-> Installing browser (thorium)"
      wget -q https://github.com/$(curl -s https://github.com/Alex313031/Thorium/releases|grep '<a href="/Alex313031/thorium/releases'|grep SSE3.zip|awk '{print substr($0,18,93)}') -P /home/$USER/apps/thorium
      unzip -qq $(ls /home/$USER/apps/thorium/) -d /home/$USER/apps/thorium
    fi
    if [[ $tlp ]]; then
      packages+="tlp "
      echo "-> tlp"
      sudo systemctl enable tlp
      curl -s https://raw.githubusercontent.com/inmymum/dotfiles/main/etc/tlp.conf | sudo tee /etc/tlp.conf > /dev/null 
    fi
      sudo pacman -S --noconfirm $packages 
    if [[ $hyprland ]]; then
      echo "-> hyprland"
      rm /home/$USER/.config/hypr/hyprland.conf
      curl -s https://raw.githubusercontent.com/inmymum/dotfiles/main/.config/hypr/hyprland.conf | tee /home/$USER/.config/hypr/hyprland.conf > /dev/null
    fi
    if [[ $autologin ]]; then
      sudo mkdir /etc/sddm.conf.d/
      echo "-> autologin"
      curl -s https://raw.githubusercontent.com/inmymum/dotfiles/main/etc/sddm.conf.d/autologin.conf | sudo tee /etc/sddm.conf.d/autologin.conf > /dev/null
    fi
    if [[ $bootmenu ]]; then
      echo "-> bootloader"
      sudo sed -i "/options/s/$/ quiet/" /boot/loader/entries/$(ls /boot/loader/entries/|grep -v fallback)
      curl -s https://raw.githubusercontent.com/inmymum/dotfiles/main/boot/loader/loader.conf | sudo tee /boot/loader/loader.conf > /dev/null
    fi
    echo "Reboot to apply"
}
echo "Run with [option]=[true/false] install() to install."
echo "Options include: $hyprland $hypridle $hyprlock $browser $tlp $autologin $bootmenu"
echo ""
echo "to install all apps and configs run:"
echo '$hyprland="true" $hypridle="true" $hyprlock="true" $browser="true" $tlp="true" $autologin="true" $bootmenu="true" install()'

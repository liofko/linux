set -x

set_vnc_server()
{
        rpm -qa gnome-remote-desktop
        [[ $? -ne 0 ]] && sudo dnf install gnome-remote-desktop -y

        grdctl vnc enable
        grdctl vnc disable-view-only
        grdctl vnc set-auth-method password
        grdctl vnc set-password "9119"

        # Fix realVNC encryption issue
        gsettings set org.gnome.desktop.remote-desktop.vnc encryption "['none']"

        systemctl --user enable gnome-remote-desktop.service
        systemctl --user restart gnome-remote-desktop.service

        sudo firewall-cmd --permanent --add-service=vnc-server
        sudo firewall-cmd --reload
}

main()
{
        set_vnc_server
}

main $*


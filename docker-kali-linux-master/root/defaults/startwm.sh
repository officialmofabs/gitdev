#!/bin/bash

# Enable Nvidia GPU support if detected
if which nvidia-smi; then
  export LIBGL_KOPPER_DRI2=1
  export MESA_LOADER_DRIVER_OVERRIDE=zink
  export GALLIUM_DRIVER=zink
fi

# Disable compositing and screen lock
if [ ! -f $HOME/.config/kwinrc ]; then
  kwriteconfig5 --file $HOME/.config/kwinrc --group Compositing --key Enabled false
fi
if [ ! -f $HOME/.config/kscreenlockerrc ]; then
  kwriteconfig5 --file $HOME/.config/kscreenlockerrc --group Daemon --key Autolock false
fi
setterm blank 0
setterm powerdown 0

# Set default bashrc
if [ ! -f $HOME/.bashlock ]; then
  sudo cp /root/.bashrc $HOME/.bashrc
  touch $HOME/.bashlock
fi

# Launch DE
/usr/bin/startplasma-x11 > /dev/null 2>&1

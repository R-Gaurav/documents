# Setting-up neovim using AppImage
## Downloading the AppImage
1. Create a directory `AppImages` in your favorite location, e.g., `~/Downloads/AppImages/` to download and store the AppImage of neovim.
2. Visit the link: https://github.com/neovim/neovim/releases
3. At the time of writing this, the latest neovim AppImage version was "Nvim 0.12.6".
4. Download the corresponding AppImage (in your `AppImages` dir) using **wget** and the link to the neovim's AppImage.
   
   a. Ensure you appropriately choose the AppImage - corresponding to your OS (say _linux_) and architecture (say _x86_64_), e.g., "_nvim-linux-x86_64.appimage_".

## Aliasing the AppImage
1. Make the AppImage executable, i.e., from your home directory, execute the following:

   `chmod +x ~/Downloads/AppImages/nvim-linux-x86_64.appimage`

2. In your `~/.bashrc`, write the following in your last line:

   `alias nv="$HOME/Downloads/AppImages/nvim-linux-x86_64.appimage`

   NOTE: You likely have **nano** or **vim** editors already installed on your linux OS.

3. Execute `nv` in terminal to verify of neovim (NVIM) is installed correctly. Alternatively, create a dummy file: `nv file.txt` to verify.

## Installing `nvchad`
`nvchad` auto-configures your neovim installation for a nice UI and with useful plugins. Installation instructions can be found at:

https://nvchad.com/docs/quickstart/install/

i.e., simply execute:

`git clone https://github.com/NvChad/starter ~/.config/nvim && nv` 

in your local terminal. Note that `nv` is used in the above command (after `&&`) instead of `nvim` because you aliased neovim to `nv` in the earlier steps. Upon executing the above command it will auto-install the related plugins.

## Install `JetBrainsMono Nerd Font`

To fix the missing icons in your nv editor, `JetBrainsMono Nerd Font` is required; more information on the abovementioned **nvchad** installation link. 

1. Download `JetBrainsMono Nerd Font` from https://www.nerdfonts.com/font-downloads
2. Open the zip, no need to extract it. Install the fonts: "JetBrainsMonoNerdFont-Bold", "JetBrainsMonoNerdFont-Light", "JetBrainsMonoNerdFont-Medium" (by double clicking and then hitting Install).
   
   a. You can install other JetBrainsMonoNerdFont" too, but the above ones should suffice.

3. Restart your Windows Terminal, otherwise it wouldn't find the new fonts.
4. Go to "Settings -> Windows PowerShell" (in left column) -> "Appearance" -> "Font face" and change your font to "JetBrainsMono Nerd Font".

And that's it! You have successfully installed **neovim** with **nvchad** with proper font support for a great UI!

## Configuring init.vim or init.lua
Look into either of the files: **init.vim** or **init.lua** in this GitHub directory and get help with Claude to prepare one for you. And yes, you can also consider these files: init.vim or init.lua as a reference point to begin with.

Happy Coding!

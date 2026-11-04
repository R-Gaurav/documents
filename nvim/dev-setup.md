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
2. 

# Installing neovim using AppImages
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

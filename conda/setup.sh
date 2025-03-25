# Get the latest Miniconda3 installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# Install Miniconda3 and follow the defaults
bash ~/Miniconda3-latest-Linux-x86_64.sh
# Remove the installer
rm ~/Miniconda3-latest-Linux-x86_64.sh
# Source the shell, zsh as preference
# source ~/.bashrc
source ~/.zshrc
# If conda not in path, add it
if ! command -v conda >/dev/null 2>&1; then
    echo "Adding conda to PATH"
    echo "export PATH=$HOME/miniconda3/bin:$PATH" >> ~/.zshrc
fi
# Then source the shell
source ~/.zshrc
# Init conda
conda init zsh

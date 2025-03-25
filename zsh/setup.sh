#!/bin/bash

set -e

# Colors for output
GREEN="\033[0;32m"
NC="\033[0m"
export ZSHRC="$HOME/.zshrc"
echo -e "${GREEN}Starting Zsh setup...${NC}"

# Check if Zsh is installed
if command -v zsh >/dev/null 2>&1; then
    echo -e "${GREEN}Zsh is already installed.${NC}"
else
    echo -e "${GREEN}Zsh is not installed. Installing...${NC}"

    # Detect OS package manager
    if command -v apt >/dev/null 2>&1; then
        sudo apt update
        sudo apt install -y zsh git curl
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y zsh git curl
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -Sy --noconfirm zsh git curl
    else
        echo "Unsupported package manager. Please install zsh manually."
        exit 1
    fi
fi

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${GREEN}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo -e "${GREEN}Oh My Zsh is already installed.${NC}"
fi


# Install plugins
echo -e "${GREEN}Installing zsh-autosuggestions...${NC}"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions || echo "Already exists"

echo -e "${GREEN}Installing zsh-syntax-highlighting...${NC}"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting 


# Add plugins if not already there
if ! grep -q "zsh-autosuggestions" "$ZSHRC"; then
    sed -i 's/^plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"
fi

echo -e "${GREEN}Zsh setup complete. To start using it, run: chsh -s $(which zsh)${NC}"

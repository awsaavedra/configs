#!/usr/bin/env bash
#
# setup.sh — First-run bootstrap for a fresh Linux/WSL2 dev environment.
# Idempotent: safe to re-run. Uses a stamp file to skip on subsequent logins.
#
set -euo pipefail

STAMP="$HOME/.setup-complete"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$STAMP" ]; then
    echo "Setup already completed. To re-run, delete $STAMP"
    exit 0
fi

echo "============================================"
echo " First-run environment setup"
echo "============================================"

# --------------------------------------------------
# 1. System packages
# --------------------------------------------------
echo "[1/7] Updating apt and installing system packages..."
sudo apt update && sudo apt upgrade -y

sudo apt install -y \
    build-essential \
    curl \
    wget \
    git \
    vim \
    tmux \
    fzf \
    ripgrep \
    fd-find \
    bat \
    htop \
    tree \
    jq \
    docker.io \
    bash-completion \
    python3 \
    python3-pip \
    python3-venv \
    zip \
    unzip \
    hugo \
    maven \
    gradle \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

# --------------------------------------------------
# 2. Symlinks for Debian/Ubuntu naming quirks
# --------------------------------------------------
echo "[2/7] Creating symlinks for bat and fd..."
mkdir -p "$HOME/.local/bin"

if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
    ln -sf "$(which batcat)" "$HOME/.local/bin/bat"
fi

if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
fi

# --------------------------------------------------
# 3. Docker — add current user to docker group
# --------------------------------------------------
echo "[3/7] Configuring Docker..."
if ! groups "$USER" | grep -q docker; then
    sudo usermod -aG docker "$USER"
    echo "  Added $USER to docker group (log out and back in to take effect)."
fi

# --------------------------------------------------
# 4. SDKMAN + Java + Kotlin
# --------------------------------------------------
echo "[4/7] Installing SDKMAN, Java 17, and Kotlin..."
if [ ! -d "$HOME/.sdkman" ]; then
    curl -s "https://get.sdkman.io" | bash
fi

# Source SDKMAN in this script so we can use sdk commands
export SDKMAN_DIR="$HOME/.sdkman"
# shellcheck source=/dev/null
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

if ! sdk current java 2>/dev/null | grep -q "17"; then
    sdk install java 17.0.13-tem || sdk install java 17.0.12-tem || sdk install java || true
fi

if ! command -v kotlin &>/dev/null; then
    sdk install kotlin || true
fi

# --------------------------------------------------
# 5. Python packages
# --------------------------------------------------
echo "[5/7] Installing Python packages..."
if [ -f "$SCRIPT_DIR/requirements.txt" ]; then
    pip3 install --user -r "$SCRIPT_DIR/requirements.txt"
else
    echo "  WARNING: requirements.txt not found at $SCRIPT_DIR/requirements.txt"
    echo "  Skipping Python packages."
fi

# --------------------------------------------------
# 6. Config files
# --------------------------------------------------
echo "[6/7] Deploying config files..."

# .bashrc
if [ -f "$SCRIPT_DIR/.bashrc" ]; then
    cp "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"
    echo "  Installed .bashrc"
fi

# .vimrc
if [ -f "$SCRIPT_DIR/.vimrc" ]; then
    cp "$SCRIPT_DIR/.vimrc" "$HOME/.vimrc"
    echo "  Installed .vimrc"
fi

# .bash_profile
if [ -f "$SCRIPT_DIR/.bash_profile" ]; then
    cp "$SCRIPT_DIR/.bash_profile" "$HOME/.bash_profile"
    echo "  Installed .bash_profile"
fi

# .tmux.conf
if [ -f "$SCRIPT_DIR/.tmux.conf" ]; then
    cp "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"
    echo "  Installed .tmux.conf"
fi

# Git config (public noreply email)
git config --global user.name "Alexander Saavedra"
git config --global user.email "4623144+awsaavedra@users.noreply.github.com"
echo "  Configured git user"

# --------------------------------------------------
# 7. Done
# --------------------------------------------------
touch "$STAMP"

echo ""
echo "============================================"
echo " Setup complete!"
echo "============================================"
echo ""
echo "Notes:"
echo "  - Log out and back in for the docker group to take effect."
echo "  - Run 'source ~/.bashrc' to reload your shell config."
echo "  - SDKMAN and ~/.local/bin are on your PATH via .bashrc."
echo ""

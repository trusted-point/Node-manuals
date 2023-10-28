#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Log file
LOG_FILE="./install.log"

# Initialize log file
echo "[INFO] [$(date +'%Y-%m-%dT%H:%M:%S')] Starting installation..." > $LOG_FILE

# Function to log error messages
warn() {
  echo -e "${RED}✖ $@${NC}" | tee -a $LOG_FILE
}

# Function to log info messages
info() {
  echo "[INFO] [$(date +'%Y-%m-%dT%H:%M:%S')] $@" >> $LOG_FILE
}

# Function to log success messages
success() {
  echo -e "${GREEN}✔ $@${NC}" | tee -a $LOG_FILE
}

# Function to get version
get_version() {
  case "$1" in
    "namada") namada --version ;;
    "protoc") protoc --version ;;
    "cometbft") cometbft version ;;
    *) echo "Unknown" ;;
  esac
}

# Function to install or update a component
install_or_update() {
  local name=$1
  local tag=$2
  local url=$3
  local install_fn=$4
  local current_version=$(get_version "$name")

  if [ "$current_version" == "$tag" ]; then
    success "$name is already installed and up-to-date."
    return
  elif [ "$current_version" != "Unknown" ]; then
    warn "$name is installed but out-of-date. Attempting to update..."
  fi

  info "Installing or updating $name to version $tag ..."
  if curl -L -o "$name.tar.gz" "$url" &>> $LOG_FILE; then
    if tar -xvf "$name.tar.gz" &>> $LOG_FILE; then
      if $install_fn; then
        rm -rf "$name.tar.gz"
        local new_version=$(get_version "$name")
        success "$name installed or updated successfully. Version: $new_version"
        return
      fi
    fi
  fi
  warn "Failed to install or update $name."
}

# Installation functions for each component
install_namada_fn() {
  sudo mv "namada-${NAMADA_TAG}-Linux-x86_64/"* /usr/local/bin/
}
install_protobuf_fn() {
  unzip -o "protobuf.zip" -d /usr/local/
}
install_cometbft_fn() {
  sudo mv "cometbft" /usr/local/bin/
}

# Validate environment variables and proceed with installation or update
[ -n "$NAMADA_TAG" ] && \
  install_or_update "namada" "$NAMADA_TAG" "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz" install_namada_fn

[ -n "$PROTOBUF_TAG" ] && \
  install_or_update "protoc" "$PROTOBUF_TAG" "https://github.com/protocolbuffers/protobuf/releases/download/$PROTOBUF_TAG/protoc-${PROTOBUF_TAG#v}-linux-x86_64.zip" install_protobuf_fn

[ -n "$COMETBFT_TAG" ] && \
  install_or_update "cometbft" "$COMETBFT_TAG" "https://github.com/cometbft/cometbft/releases/download/$COMETBFT_TAG/cometbft_${COMETBFT_TAG#v}_linux_amd64.tar.gz" install_cometbft_fn

echo -e "${YELLOW}🎉 Installation or update completed! Check the log file for more details.${NC}" | tee -a $LOG_FILE

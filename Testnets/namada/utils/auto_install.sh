#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Initialize log file
LOG_FILE="./install.log"
echo "[INFO] [$(date +'%Y-%m-%dT%H:%M:%S')] Starting installation..." > $LOG_FILE

# Function to log error messages
log_error() {
  echo -e "${RED}❌ $@${NC}"
  echo "[ERROR] [$(date +'%Y-%m-%dT%H:%M:%S')] $@" >> $LOG_FILE
}

# Function to log info messages
log_info() {
  echo "[INFO] [$(date +'%Y-%m-%dT%H:%M:%S')] $@" >> $LOG_FILE
}

# Function to log success messages
log_success() {
  echo -e "${GREEN}✔️ $@${NC}"
  echo "[SUCCESS] [$(date +'%Y-%m-%dT%H:%M:%S')] $@" >> $LOG_FILE
}

# Function to log warning messages
log_warning() {
  echo -e "${YELLOW}⚠️ $@${NC}"
  echo "[WARNING] [$(date +'%Y-%m-%dT%H:%M:%S')] $@" >> $LOG_FILE
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
  local file_extension=$4
  local install_fn=$5

  local current_version=$(get_version "$name")
  local action="Installed"

  if [ "$current_version" == "$tag" ]; then
    log_success "$name is up-to-date."
    return
  elif [ "$current_version" != "Unknown" ]; then
    action="Updated"
  fi

  log_info "Downloading $name..."
  if ! curl -L -o "$name.$file_extension" "$url" >> $LOG_FILE 2>&1 || \
     ! $install_fn >> $LOG_FILE 2>&1; then
    log_error "Failed to install $name."
    return 1
  fi
  
  rm -rf "$name.$file_extension"
  local new_version=$(get_version "$name")
  log_success "$action $name to $new_version"
}

# Installation functions for each component
install_namada_fn() {
  tar -xvf "namada.tar.gz" && sudo mv "namada-${NAMADA_TAG}-Linux-x86_64/"* /usr/local/bin/
}
install_protobuf_fn() {
  unzip -o "protoc.zip" -d /usr/local/
}
install_cometbft_fn() {
  tar -xvf "cometbft.tar.gz" && sudo mv "cometbft" /usr/local/bin/
}

# Validate environment variables and proceed with installation or update
[ -n "$NAMADA_TAG" ] && \
  install_or_update "namada" "$NAMADA_TAG" "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz" "tar.gz" install_namada_fn

[ -n "$PROTOBUF_TAG" ] && \
  install_or_update "protoc" "$PROTOBUF_TAG" "https://github.com/protocolbuffers/protobuf/releases/download/$PROTOBUF_TAG/protoc-${PROTOBUF_TAG#v}-linux-x86_64.zip" "zip" install_protobuf_fn

[ -n "$COMETBFT_TAG" ] && \
  install_or_update "cometbft" "$COMETBFT_TAG" "https://github.com/cometbft/cometbft/releases/download/$COMETBFT_TAG/cometbft_${COMETBFT_TAG#v}_linux_amd64.tar.gz" "tar.gz" install_cometbft_fn

echo -e "${GREEN}🎉 Installation completed! For more details, check the log file.${NC}"

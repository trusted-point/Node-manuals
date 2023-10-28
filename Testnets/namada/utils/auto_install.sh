#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print error messages
error() {
  echo -e "${RED}[ERROR] [$(date +'%Y-%m-%dT%H:%M:%S')] $@${NC}" 1>&2
  exit 1
}

# Function to print info messages
info() {
  echo -e "${BLUE}[INFO] [$(date +'%Y-%m-%dT%H:%M:%S')] $@${NC}"
}

# Function to print success messages
success() {
  echo -e "${GREEN}[SUCCESS] [$(date +'%Y-%m-%dT%H:%M:%S')] $@${NC}"
}

# Check if required utilities are installed
for util in curl tar unzip sudo; do
  command -v $util >/dev/null 2>&1 || error "$util is not installed."
done

# Validate environment variables
[ -z "$NAMADA_TAG" ] && error "NAMADA_TAG is not set."
[ -z "$PROTOBUF_TAG" ] && error "PROTOBUF_TAG is not set."
[ -z "$COMETBFT_TAG" ] && error "COMETBFT_TAG is not set."

# Function to install Namada
install_namada() {
  info "Installing Namada version $NAMADA_TAG ..."
  curl -L -o namada.tar.gz "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz" || error "Failed to download Namada."
  tar -xvf namada.tar.gz || error "Failed to extract Namada archive."
  sudo mv namada-${NAMADA_TAG}-Linux-x86_64/* /usr/local/bin/ || error "Failed to move Namada binaries."
  rm -rf namada-${NAMADA_TAG}-Linux-x86_64 namada.tar.gz
  success "Namada installed successfully."
}

# Function to install Protocol Buffers
install_protobuf() {
  info "Installing Protocol Buffers version $PROTOBUF_TAG ..."
  curl -L -o protobuf.zip "https://github.com/protocolbuffers/protobuf/releases/download/$PROTOBUF_TAG/protoc-${PROTOBUF_TAG#v}-linux-x86_64.zip" || error "Failed to download Protocol Buffers."
  unzip -o protobuf.zip -d /usr/local/ || error "Failed to extract Protocol Buffers archive."
  rm protobuf.zip
  success "Protocol Buffers installed successfully."
}

# Function to install CometBFT
install_cometbft() {
  info "Installing CometBFT version $COMETBFT_TAG ..."
  curl -L -o cometbft.tar.gz "https://github.com/cometbft/cometbft/releases/download/$COMETBFT_TAG/cometbft_${COMETBFT_TAG#v}_linux_amd64.tar.gz" || error "Failed to download CometBFT."
  tar -xvf cometbft.tar.gz || error "Failed to extract CometBFT archive."
  sudo mv cometbft /usr/local/bin/ || error "Failed to move CometBFT binaries."
  rm cometbft.tar.gz
  success "CometBFT installed successfully."
}

# Installation steps
install_namada
install_protobuf
install_cometbft

echo -e "${YELLOW}[INFO] [$(date +'%Y-%m-%dT%H:%M:%S')] 🎉 All packages were successfully installed!${NC}"

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

# Function to log error messages and exit
error() {
  echo -e "${RED}✖ $@${NC}" | tee -a $LOG_FILE
  exit 1
}

# Function to log info messages
info() {
  echo "[INFO] [$(date +'%Y-%m-%dT%H:%M:%S')] $@" >> $LOG_FILE
}

# Function to log success messages
success() {
  echo -e "${GREEN}✔ $@${NC}" | tee -a $LOG_FILE
}

# Check if required utilities are installed
for util in curl tar unzip sudo; do
  command -v $util >/dev/null 2>&1 || error "$util is not installed."
done

# Validate environment variables
[ -z "$NAMADA_TAG" ] && error "NAMADA_TAG is not set."
[ -z "$PROTOBUF_TAG" ] && error "PROTOBUF_TAG is not set."
[ -z "$COMETBFT_TAG" ] && error "COMETBFT_TAG is not set."

# ASCII Art for beautiful output
echo -e "${YELLOW}"
cat << "EOF"
  _____           _        _ _           
 |_   _|         | |      | | |          
   | |  _ __  ___| |_ __ _| | | ___ _ __ 
   | | | '_ \/ __| __/ _` | | |/ _ \ '__|
  _| |_| | | \__ \ || (_| | | |  __/ |   
 |_____|_| |_|___/\__\__,_|_|_|\___|_|   
EOF
echo -e "${NC}"

# Function to install Namada
install_namada() {
  info "Installing Namada version $NAMADA_TAG ..."
  curl -L -o namada.tar.gz "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz" &>> $LOG_FILE || error "Failed to download Namada."
  tar -xvf namada.tar.gz &>> $LOG_FILE || error "Failed to extract Namada archive."
  sudo mv namada-${NAMADA_TAG}-Linux-x86_64/* /usr/local/bin/ || error "Failed to move Namada binaries."
  rm -rf namada-${NAMADA_TAG}-Linux-x86_64 namada.tar.gz
  namada_version=$(namada --version 2>&1) || error "Failed to get Namada version."
  success "Namada installed successfully. Version: $namada_version"
}

# Function to install Protocol Buffers
install_protobuf() {
  info "Installing Protocol Buffers version $PROTOBUF_TAG ..."
  curl -L -o protobuf.zip "https://github.com/protocolbuffers/protobuf/releases/download/$PROTOBUF_TAG/protoc-${PROTOBUF_TAG#v}-linux-x86_64.zip" &>> $LOG_FILE || error "Failed to download Protocol Buffers."
  unzip -o protobuf.zip -d /usr/local/ &>> $LOG_FILE || error "Failed to extract Protocol Buffers archive."
  rm protobuf.zip
  protoc_version=$(protoc --version 2>&1) || error "Failed to get Protocol Buffers version."
  success "Protocol Buffers installed successfully. Version: $protoc_version"
}

# Function to install CometBFT
install_cometbft() {
  info "Installing CometBFT version $COMETBFT_TAG ..."
  curl -L -o cometbft.tar.gz "https://github.com/cometbft/cometbft/releases/download/$COMETBFT_TAG/cometbft_${COMETBFT_TAG#v}_linux_amd64.tar.gz" &>> $LOG_FILE || error "Failed to download CometBFT."
  tar -xvf cometbft.tar.gz &>> $LOG_FILE || error "Failed to extract CometBFT archive."
  sudo mv cometbft /usr/local/bin/ || error "Failed to move CometBFT binaries."
  rm cometbft.tar.gz
  cometbft_version=$(cometbft version 2>&1) || error "Failed to get CometBFT version."
  success "CometBFT installed successfully. Version: $cometbft_version"
}

# Installation steps
install_namada
install_protobuf
install_cometbft

echo -e "${YELLOW}🎉 All packages were successfully installed!${NC}" | tee -a $LOG_FILE


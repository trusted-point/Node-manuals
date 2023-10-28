#!/bin/bash

# Define color codes for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print info messages
info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

# Function to print success messages
success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Function to print error messages and exit
error_exit() {
  echo -e "${RED}[ERROR]${NC} $1"
  exit 1
}

# Function to check the last command's exit status
check_status() {
  if [ $? -ne 0 ]; then
    error_exit "$1"
  fi
}

# Create a temporary directory
TMP_DIR=$(mktemp -d)
check_status "Failed to create a temporary directory."
cd "$TMP_DIR" || error_exit "Failed to navigate to the temporary directory."

# Install Namada
info "Installing Namada..."
curl -s -L -o namada.tar.gz "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz"
tar -xvf namada.tar.gz
sudo mv namada-${NAMADA_TAG}-Linux-x86_64/* /usr/local/bin/
rm -rf namada-${NAMADA_TAG}-Linux-x86_64 namada.tar.gz
namada_version=$(namada -V 2>/dev/null)
check_status "Failed to install Namada."
success "$namada_version successfully installed."

# Install Protocol Buffers
info "Installing Protocol Buffers..."
curl -s -L -o protobuf.zip "https://github.com/protocolbuffers/protobuf/releases/download/$PROTOBUF_TAG/protoc-${PROTOBUF_TAG#v}-linux-x86_64.zip"
mkdir protobuf_temp && unzip protobuf.zip -d protobuf_temp/
sudo cp protobuf_temp/bin/protoc /usr/local/bin/
sudo cp -r protobuf_temp/include/* /usr/local/include/
rm -rf protobuf_temp protobuf.zip
protobuf_version=$(protoc --version 2>/dev/null)
check_status "Failed to install Protocol Buffers."
success "$protobuf_version successfully installed."

# Install CometBFT
info "Installing CometBFT..."
curl -s -L -o cometbft.tar.gz "https://github.com/cometbft/cometbft/releases/download/$COMETBFT_TAG/cometbft_${COMETBFT_TAG#v}_linux_amd64.tar.gz"
mkdir cometbft_temp && tar -xvf cometbft.tar.gz -C cometbft_temp/
sudo mv cometbft_temp/cometbft /usr/local/bin/
rm -rf cometbft_temp cometbft.tar.gz
cometbft_version=$(cometbft --version 2>/dev/null)
check_status "Failed to install CometBFT."
success "$cometbft_version successfully installed."

# Clean up
cd - > /dev/null || error_exit "Failed to return to the original directory."
rm -rf "$TMP_DIR"

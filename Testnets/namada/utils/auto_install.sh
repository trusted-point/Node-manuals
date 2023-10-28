#!/bin/bash

# Define logging colors
RED='[0;31m'
GREEN='[0;32m'
NC='[0m'  # No Color

# Function for error messages
error() {
    echo -e "${RED}[ERROR]${NC} $1" 1>&2
    exit 1
}

# Function for success messages
success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Function for installing a package
install_package() {
    local tag=$1
    local url=$2
    local archive_name=$3
    local temp_folder=$4
    local extract_command=$5
    local move_command=$6
    local remove_command=$7
    local version_command=$8

    echo "[INFO] Downloading $archive_name..."
    curl -sL -o $archive_name $url || error "Failed to download $archive_name"

    echo "[INFO] Extracting $archive_name..."
    $extract_command || error "Failed to extract $archive_name"

    echo "[INFO] Installing..."
    $move_command || error "Failed to install"
    
    echo "[INFO] Cleaning up..."
    $remove_command || error "Failed to clean up"

    echo "[INFO] Verifying installation..."
    $version_command &> /dev/null || error "Verification failed"
    success "$($version_command) successfully installed."
}

# Validate tags
[[ -z "$NAMADA_TAG" || -z "$PROTOBUF_TAG" || -z "$COMETBFT_TAG" ]] && error "Tags are not properly set."

# Install Namada
install_package "$NAMADA_TAG" "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz" "namada.tar.gz" "namada_temp" "tar -xzf namada.tar.gz" "sudo mv namada-${NAMADA_TAG}-Linux-x86_64/* /usr/local/bin/" "rm -rf namada-${NAMADA_TAG}-Linux-x86_64 namada.tar.gz" "namada -V"

# Install Protocol Buffers
install_package "$PROTOBUF_TAG" "https://github.com/protocolbuffers/protobuf/releases/download/$PROTOBUF_TAG/protoc-${PROTOBUF_TAG#v}-linux-x86_64.zip" "protobuf.zip" "protobuf_temp" "unzip -q protobuf.zip -d protobuf_temp/" "sudo cp protobuf_temp/bin/protoc /usr/local/bin/ && sudo cp -r protobuf_temp/include/* /usr/local/include/" "rm -rf protobuf_temp protobuf.zip" "protoc --version"

# Install CometBFT
install_package "$COMETBFT_TAG" "https://github.com/cometbft/cometbft/releases/download/$COMETBFT_TAG/cometbft_${COMETBFT_TAG#v}_linux_amd64.tar.gz" "cometbft.tar.gz" "cometbft_temp" "tar -xzf cometbft.tar.gz -C cometbft_temp/" "sudo mv cometbft_temp/cometbft /usr/local/bin/" "rm -rf cometbft_temp cometbft.tar.gz" "cometbft --version"

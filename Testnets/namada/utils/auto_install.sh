#!/bin/bash

# Color codes for pretty logging
RED='[0;31m'
GREEN='[0;32m'
NC='[0m'  # No Color

# Function to print error messages
error_exit() {
    echo -e "${RED}[ERROR] $1${NC}"
    exit 1
}

# Function to print success messages
success() {
    echo -e "${GREEN}[SUCCESS] $1${NC}"
}

# Function to install software packages
install_package() {
    local tag=$1
    local download_url=$2
    local archive_name=$3
    local temp_folder=$4
    local extract_cmd=$5
    local move_cmd=$6
    local cleanup_cmd=$7
    local verify_cmd=$8

    # Download
    echo "[INFO] Downloading $archive_name..."
    curl -s -L -o $archive_name $download_url || error_exit "Failed to download $archive_name"

    # Extract
    echo "[INFO] Extracting $archive_name..."
    $extract_cmd || error_exit "Failed to extract $archive_name"

    # Move to installation path
    echo "[INFO] Installing..."
    $move_cmd || error_exit "Failed to install"

    # Cleanup
    echo "[INFO] Cleaning up..."
    $cleanup_cmd || error_exit "Failed to clean up"

    # Verify Installation
    echo "[INFO] Verifying Installation..."
    $verify_cmd &> /dev/null || error_exit "Verification failed"
    success "$($verify_cmd) successfully installed."
}

# User prompt for software versions
read -p "Enter the version tag for Namada (e.g., v0.23.1): " NAMADA_TAG
read -p "Enter the version tag for Protocol Buffers (e.g., v24.4): " PROTOBUF_TAG
read -p "Enter the version tag for CometBFT (e.g., v0.37.2): " COMETBFT_TAG

# Validate input tags
[[ -z "$NAMADA_TAG" || -z "$PROTOBUF_TAG" || -z "$COMETBFT_TAG" ]] && error_exit "Tags are not properly set."

# Install Namada
install_package "$NAMADA_TAG" "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz" "namada.tar.gz" "namada-${NAMADA_TAG}-Linux-x86_64" "tar -xzf namada.tar.gz" "sudo mv namada-${NAMADA_TAG}-Linux-x86_64/* /usr/local/bin/" "rm -rf namada-${NAMADA_TAG}-Linux-x86_64 namada.tar.gz" "namada --version"

# Install Protocol Buffers
install_package "$PROTOBUF_TAG" "https://github.com/protocolbuffers/protobuf/releases/download/$PROTOBUF_TAG/protoc-${PROTOBUF_TAG#v}-linux-x86_64.zip" "protobuf.zip" "protobuf_temp" "unzip -q protobuf.zip -d protobuf_temp/" "sudo cp protobuf_temp/bin/protoc /usr/local/bin/ && sudo cp -r protobuf_temp/include/* /usr/local/include/" "rm -rf protobuf_temp protobuf.zip" "protoc --version"

# Install CometBFT
install_package "$COMETBFT_TAG" "https://github.com/cometbft/cometbft/releases/download/$COMETBFT_TAG/cometbft_${COMETBFT_TAG#v}_linux_amd64.tar.gz" "cometbft.tar.gz" "cometbft_temp" "tar -xzf cometbft.tar.gz -C cometbft_temp/" "sudo mv cometbft_temp/cometbft /usr/local/bin/" "rm -rf cometbft_temp cometbft.tar.gz" "cometbft version"

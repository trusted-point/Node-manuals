#!/bin/bash

# Define color codes for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Define log file
LOG_FILE="./install.log"

# Function to log messages
log() {
  echo "$1" >> "$LOG_FILE"
}

# Function to print info messages
info() {
  echo -e "${BLUE}[INFO]${NC} $1"
  log "[INFO] $1"
}

# Function to print success messages
success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
  log "[SUCCESS] $1"
}

# Function to print error messages and exit
error_exit() {
  echo -e "${RED}[ERROR]${NC} $1"
  log "[ERROR] $1"
  exit 1
}

# Function to validate environment variables
validate_var() {
  if [[ ! "$1" =~ ^v[0-9]+\.[0-9]+(\.[0-9]+)?$ ]]; then
    error_exit "Invalid version format for $2. Expected format is 'vX.Y.Z'."
  fi
}

# Validate environment variables
validate_var "$NAMADA_TAG" "NAMADA_TAG"
validate_var "$PROTOBUF_TAG" "PROTOBUF_TAG"
validate_var "$COMETBFT_TAG" "COMETBFT_TAG"

# Your existing functions and main code here
# ...

# Function to install a package
install_package() {
  local tag=$1
  local url=$2
  local tar_name=$3
  local install_path=$4
  local version_command=$5

  info "Downloading package..."
  curl -s -L -o "$tar_name" "$url"
  check_status "Failed to download package."

  info "Extracting package..."
  if [[ "$tar_name" == *.tar.gz ]]; then
    tar -xf "$tar_name"
  elif [[ "$tar_name" == *.zip ]]; then
    unzip -q "$tar_name" -d "$install_path"
  fi
  check_status "Failed to extract package."

  info "Installing package..."
  if [[ "$tar_name" == *.tar.gz ]]; then
    sudo mv "${tar_name%.tar.gz}"/* "$install_path"
  fi
  check_status "Failed to install package."

  info "Cleaning up..."
  rm -rf "$tar_name" "${tar_name%.tar.gz}"
  check_status "Failed to clean up."

  info "Verifying installation..."
  local version=$($version_command 2>/dev/null)
  check_status "Failed to verify installation."
  success "$version successfully installed."
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
install_package "$NAMADA_TAG" "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz" "namada.tar.gz" "/usr/local/bin" "namada -V"

# Install Protocol Buffers
install_package "$PROTOBUF_TAG" "https://github.com/protocolbuffers/protobuf/releases/download/$PROTOBUF_TAG/protoc-${PROTOBUF_TAG#v}-linux-x86_64.zip" "protobuf.zip" "/usr/local" "protoc --version"

# Install CometBFT
install_package "$COMETBFT_TAG" "https://github.com/cometbft/cometbft/releases/download/$COMETBFT_TAG/cometbft_${COMETBFT_TAG#v}_linux_amd64.tar.gz" "cometbft.tar.gz" "/usr/local/bin" "cometbft --version"

# Clean up
cd - > /dev/null || error_exit "Failed to return to the original directory."
rm -rf "$TMP_DIR"

# End of script

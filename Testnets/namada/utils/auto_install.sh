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

# Function to install a package
install_package() {
  local tag=$1
  local url=$2
  local tar_name=$3
  local install_path=$4
  local temp_folder=$5
  local version_command=$6
  local custom_commands=$7

  info "Downloading package..."
  curl -s -L -o "$tar_name" "$url"
  if [ $? -ne 0 ]; then
    error_exit "Failed to download package."
  fi

  if [[ "$custom_commands" != "none" ]]; then
    mkdir $temp_folder && tar -xvf $tar_name -C $temp_folder/
  else
    tar -xvf $tar_name
  fi

  if [[ "$custom_commands" == "protobuf" ]]; then
    sudo cp $temp_folder/bin/protoc $install_path
    sudo cp -r $temp_folder/include/* /usr/local/include/
  elif [[ "$custom_commands" == "cometbft" ]]; then
    sudo mv $temp_folder/cometbft $install_path
  else
    sudo mv namada-${tag}-Linux-x86_64/* $install_path
  fi

  rm -rf $temp_folder $tar_name

  local version=$($version_command 2>/dev/null)
  if [ $? -ne 0 ]; then
    error_exit "Failed to verify installation."
  fi

  success "$version successfully installed."
}

# Create a temporary directory and navigate into it
TMP_DIR=$(mktemp -d)
if [ $? -ne 0 ]; then
  error_exit "Failed to create a temporary directory."
fi
cd "$TMP_DIR"

# Install Namada
install_package "$NAMADA_TAG" "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz" "namada.tar.gz" "/usr/local/bin" "none" "namada -V" "none"

# Install Protocol Buffers
install_package "$PROTOBUF_TAG" "https://github.com/protocolbuffers/protobuf/releases/download/$PROTOBUF_TAG/protoc-${PROTOBUF_TAG#v}-linux-x86_64.zip" "protobuf.zip" "/usr/local/bin" "protobuf_temp" "protoc --version" "protobuf"

# Install CometBFT
install_package "$COMETBFT_TAG" "https://github.com/cometbft/cometbft/releases/download/$COMETBFT_TAG/cometbft_${COMETBFT_TAG#v}_linux_amd64.tar.gz" "cometbft.tar.gz" "/usr/local/bin" "cometbft_temp" "cometbft --version" "cometbft"

# Cleanup and exit
cd - > /dev/null || error_exit "Failed to return to the original directory."
rm -rf "$TMP_DIR"

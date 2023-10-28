#!/bin/bash

# Function to print info messages
info() {
  echo -e "\\e[34m[INFO]\\e[0m $1"
}

# Function to print success messages
success() {
  echo -e "\\e[32m[SUCCESS]\\e[0m $1"
}

# Function to print error messages and exit
error_exit() {
  echo -e "\\e[31m[ERROR]\\e[0m $1"
  exit 1
}

# Check for required commands
for cmd in curl tar sudo; do
  command -v $cmd >/dev/null 2>&1 || error_exit "The required command '$cmd' is not installed."
done

# Ensure the NAMADA_TAG environment variable is set
if [ -z "$NAMADA_TAG" ]; then
  error_exit "The NAMADA_TAG environment variable is not set. Please set it and rerun the script."
fi

# Main installation process
info "Starting installation..."

TMP_DIR=$(mktemp -d) || error_exit "Failed to create a temporary directory."
info "Temporary directory created: $TMP_DIR"

cd $TMP_DIR || error_exit "Failed to change to the temporary directory."

info "Downloading Namada..."
curl -s -L -o namada.tar.gz "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz" || error_exit "Download failed."

info "Extracting Namada..."
tar -xf namada.tar.gz || error_exit "Extraction failed."

info "Installing Namada..."
sudo mv namada-${NAMADA_TAG}-Linux-x86_64/* /usr/local/bin/ || error_exit "Installation failed."

info "Cleaning up..."
cd - > /dev/null || error_exit "Failed to return to the original directory."
rm -rf $TMP_DIR || error_exit "Failed to remove the temporary directory."

# Fetch and display the installed version
VERSION=$(namada -V 2>/dev/null) || error_exit "Failed to retrieve the installed version."
success "$VERSION successfully installed."

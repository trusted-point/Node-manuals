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

# Function to install required utilities
install_util() {
  case "$OSTYPE" in
    linux*)
      sudo apt-get update && sudo apt-get install -y $1 || warn "Failed to install $1."
      ;;
    darwin*)
      brew install $1 || warn "Failed to install $1."
      ;;
    *)
      warn "Unsupported operating system."
      ;;
  esac
}

# Check if required utilities are installed and install if not
for util in curl tar unzip sudo; do
  if ! command -v $util >/dev/null 2>&1; then
    warn "$util is not installed. Attempting to install..."
    install_util $util
  fi
done

# Validate environment variables
[ -z "$NAMADA_TAG" ] && warn "NAMADA_TAG is not set."
[ -z "$PROTOBUF_TAG" ] && warn "PROTOBUF_TAG is not set."
[ -z "$COMETBFT_TAG" ] && warn "COMETBFT_TAG is not set."

# Set installation directories (can be overridden by user)
NAMADA_DIR=${NAMADA_DIR:-/usr/local/bin}
PROTOBUF_DIR=${PROTOBUF_DIR:-/usr/local}
COMETBFT_DIR=${COMETBFT_DIR:-/usr/local/bin}

# Function to install Namada
install_namada() {
  if [ -n "$NAMADA_TAG" ]; then
    if ! command -v namada >/dev/null 2>&1; then
      info "Installing Namada version $NAMADA_TAG ..."
      curl -L -o namada.tar.gz "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz" &>> $LOG_FILE && \
      tar -xvf namada.tar.gz &>> $LOG_FILE && \
      sudo mv namada-${NAMADA_TAG}-Linux-x86_64/* $NAMADA_DIR && \
      rm -rf namada-${NAMADA_TAG}-Linux-x86_64 namada.tar.gz && \
      namada_version=$(namada --version 2>&1) && \
      success "Namada installed successfully. Version: $namada_version" || warn "Failed to install Namada."
    else
      success "Namada is already installed."
    fi
  fi
}

# Function to install Protocol Buffers
install_protobuf() {
  if [ -n "$PROTOBUF_TAG" ]; then
    if ! command -v protoc >/dev/null 2>&1; then
      info "Installing Protocol Buffers version $PROTOBUF_TAG ..."
      curl -L -o protobuf.zip "https://github.com/protocolbuffers/protobuf/releases/download/$PROTOBUF_TAG/protoc-${PROTOBUF_TAG#v}-linux-x86_64.zip" &>> $LOG_FILE && \
      unzip -o protobuf.zip -d $PROTOBUF_DIR &>> $LOG_FILE && \
      rm protobuf.zip && \
      protoc_version=$(protoc --version 2>&1) && \
      success "Protocol Buffers installed successfully. Version: $protoc_version" || warn "Failed to install Protocol Buffers."
    else
      success "Protocol Buffers is already installed."
    fi
  fi
}

# Function to install CometBFT
install_cometbft() {
  if [ -n "$COMETBFT_TAG" ]; then
    if ! command -v cometbft >/dev/null 2>&1; then
      info "Installing CometBFT version $COMETBFT_TAG ..."
      curl -L -o cometbft.tar.gz "https://github.com/cometbft/cometbft/releases/download/$COMETBFT_TAG/cometbft_${COMETBFT_TAG#v}_linux_amd64.tar.gz" &>> $LOG_FILE && \
      tar -xvf cometbft.tar.gz &>> $LOG_FILE && \
      sudo mv cometbft $COMETBFT_DIR && \
      rm cometbft.tar.gz && \
      cometbft_version=$(cometbft version 2>&1) && \
      success "CometBFT installed successfully. Version: $cometbft_version" || warn "Failed to install CometBFT."
    else
      success "CometBFT is already installed."
    fi
  fi
}

# Installation steps
install_namada
install_protobuf
install_cometbft

echo -e "${YELLOW}🎉 Installation completed! Check the log file for more details.${NC}" | tee -a $LOG_FILE

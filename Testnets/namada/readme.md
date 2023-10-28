# 🌐 Namada Node Setup Guide

> 🚀 This guide will walk you through the process of setting up a Namada node. Follow these steps to ensure a smooth setup process!

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation of Required Binaries](#installation-of-required-binaries)
- [Node Initialization](#node-initialization)
- [Service Creation for Node Startup](#service-creation-for-node-startup)
- [Additional Steps for Post-Genesis Validators](#additional-steps-for-post-genesis-validators)

---

## 🛠️ Prerequisites

Before you begin, make sure you have `curl` and `sudo` access on a Linux-based system.

---

## ⚙️ Installation of Required Binaries

### 📦 Namada

```bash
NAMADA_TAG="v0.23.1"
curl -L -o namada.tar.gz "https://github.com/anoma/namada/releases/download/$NAMADA_TAG/namada-${NAMADA_TAG}-Linux-x86_64.tar.gz"
tar -xvf namada.tar.gz
sudo mv namada-${NAMADA_TAG}-Linux-x86_64/* /usr/local/bin/
rm -rf namada-${NAMADA_TAG}-Linux-x86_64 namada.tar.gz
```

### 🔄 Protocol Buffers

```bash
PROTOBUF_TAG="v24.4"
curl -L -o protobuf.zip "https://github.com/protocolbuffers/protobuf/releases/download/$PROTOBUF_TAG/protoc-${PROTOBUF_TAG#v}-linux-x86_64.zip"
unzip -o protobuf.zip -d /usr/local/
rm protobuf.zip

```

### 🌠 CometBFT

```bash
COMETBFT_TAG="v0.37.2"
curl -L -o cometbft.tar.gz "https://github.com/cometbft/cometbft/releases/download/$COMETBFT_TAG/cometbft_${COMETBFT_TAG#v}_linux_amd64.tar.gz"
tar -xvf cometbft.tar.gz
sudo mv cometbft /usr/local/bin/
rm cometbft.tar.gz
```

---

## 🌟 Node Initialization

```bash
mkdir -p $HOME/.local/share/namada/pre-genesis/
CHAIN_ID="public-testnet-14.5d79b6958580"
echo "export CHAIN_ID=$CHAIN_ID" >> ~/.bashrc
```

### For Pre-Genesis Validators

```bash
ALIAS=$(basename $(ls -d $HOME/.local/share/namada/pre-genesis/*/) | head -n 1)
echo "export ALIAS=$ALIAS" >> ~/.bashrc
namada client utils join-network --chain-id $CHAIN_ID --genesis-validator $ALIAS
```

### For Full Nodes & Post-Genesis Validators

```bash
namada client utils join-network --chain-id $CHAIN_ID
```

---

## 🔄 Service Creation for Node Startup

```bash
# Paste the Systemd Service File content here
sudo systemctl daemon-reload
sudo systemctl enable namadad
sudo systemctl restart namadad
```

---

## 🌐 Additional Steps for Post-Genesis Validators

```bash
ALIAS=<your-validator-alias-here>
echo "export ALIAS=$ALIAS" >> ~/.bashrc
namada wallet address gen --alias $ALIAS
# Additional setup commands here
```

---

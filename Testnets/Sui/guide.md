[<img src = https://user-images.githubusercontent.com/80550154/227659988-db065408-a22e-4de4-86ee-93ef55738750.png alt='banner' width= '99.9%'>]()
___
## About **Sui**
* **[Sui](https://sui.io/)** is a boundless platform to build rich and dynamic on-chain assets from gaming to finance.
* Sui is the first permissionless Layer 1 blockchain designed from the ground up to enable creators and developers to build experiences that cater to the next billion users in web3.
* The power of the sui element lies in its fluidity—its ability to easily adapt to and transform any environment. Similarly, the Sui platform seeks to provide a flexible network that you can leverage to shape the web3 landscape.

<font size = 4>**[Website](https://sui.io/) | [GitHub](https://github.com/MystenLabs/sui) | [Twitter](https://twitter.com/SuiNetwork) | [Discord](https://discord.gg/sui) | [Docs](https://docs.sui.io/) | [Whitepaper](https://github.com/MystenLabs/sui/blob/main/doc/paper/sui.pdf) | [Blog](https://medium.com/mysten-labs)**</font>
___

## Fullnode installation guide (devnet)

### Navigation
* [Server requirements](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Sui/guide.md#server-requirements)
* [Insatll a fullnode on a clean server](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Sui/guide.md#1-update-required-packages)
* [Monitore a fullnode performance](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Sui/guide.md#monitor-your-fullnodes-performance)
* [Update a fullnode](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Sui/guide.md#update-a-fullnode)
* [Useful commands](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Sui/guide.md#useful-commands)
* [Fully remove a fullnode from the server](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Sui/guide.md#5-delete-sui-node-from-your-server)
___
 ### _Sui Full nodes validate blockchain activities, including transactions, checkpoints, and epoch changes. Each Full node stores and services the queries for the blockchain state and history._
 ___

### `Server requirements`
```GO
OS: Ubuntu 20.04
CPUs: 10 core
RAM: 32 GB
Storage: 1 TB
```

### 1. Update `required packages`

```bash
sudo apt-get update && sudo apt-get install -y --no-install-recommends tzdata libprotobuf-dev ca-certificates build-essential libssl-dev libclang-dev pkg-config openssl protobuf-compiler git clang cmake -y
```
### 2. Install `Rust`
```bash 
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
rustc --version
```
### 3. Create a directory for database, genesis.blob, fullnode.yaml
```bash
mkdir $HOME.sui
```
### 4. Clone a GitHub repository
```bash 
cd $HOME
git clone https://github.com/MystenLabs/sui.git
cd sui
git remote add upstream https://github.com/MystenLabs/sui
git fetch upstream
git checkout --track upstream/devnet
```
### 5. Copy a `fullnode.yaml` and the update path
```bash 
cp crates/sui-config/data/fullnode-template.yaml $HOME/.sui/fullnode.yaml

sed -i.bak "s|db-path:.*|db-path: \"$HOME\/.sui\/db\"| ; s|genesis-file-location:.*|genesis-file-location: \"$HOME\/.sui\/genesis.blob\"| ; s|127.0.0.1|0.0.0.0|" $HOME/.sui/fullnode.yaml
```
### 6. Download `genesis.blob` for devnet.
```bash
wget -P $HOME/.sui https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
```
### 7. Compile `sui-node` and `sui` binaries.
```bash
cargo build --release -p sui-node -p sui
```
### 8. `Move both binary files` to the right directory 
```bash
mv ~/sui/target/release/sui-node /usr/local/bin/
mv ~/sui/target/release/sui /usr/local/bin/
```

### 9. Create a service file.
```bash
echo "[Unit]
Description=Sui Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/sui-node --config-path $HOME/.sui/fullnode.yaml
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/suid.service
```
```bash
mv $HOME/suid.service /etc/systemd/system/
```

### 10. Run a fullnode and check logs 
```bash
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable suid
sudo systemctl start suid
```
```bash
journalctl -u suid -f
```
___
## Monitor your fullnode's performance 
### 1. Compare the number of checkpoints on your node and on chain
```bash
curl -q localhost:9184/metrics 2>/dev/null |grep '^highest_synced_checkpoint'; echo
```
```bash
curl --location --request POST 'https://fullnode.devnet.sui.io:443/' --header 'Content-Type: application/json' --data-raw '{"jsonrpc":"2.0", "id":1,"method":"sui_getLatestCheckpointSequenceNumber"}'; echo
```
### 2. Compare the number of transactions on your node and on chain
```bash
curl --location --request POST http://127.0.0.1:9000/ --header 'Content-Type: application/json' --data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}'; echo 
```

```bash
curl --location --request POST https://fullnode.testnet.sui.io:443 --header 'Content-Type: application/json' --data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionNumber","id":1}'; echo
```
### 3. You can also use [Scale3](https://www.scale3labs.com/check/sui) monitoring platform

To get your ip use:
```bash
wget -qO- eth0.me
```
___
## Update a fullnode
### 1. Stop the node 
```bash
 sudo systemctl stop suid
```

### 2. Update Sui repository to the latest commit
```bash 
cd $HOME/sui

git remote add upstream https://github.com/MystenLabs/sui

git fetch upstream

git checkout -B devnet --track upstream/devnet
```
### 3. Compile binaries
```bash
cargo build --release -p sui-node -p sui
```
### 4. Move them to the right path
```bash
mv ~/sui/target/release/sui-node /usr/local/bin/
mv ~/sui/target/release/sui /usr/local/bin/
```
### 5. Update genesis.blob
```bash
wget -qO /var/sui/genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
```
### 6. Wipe database
```bash
 rm -rf /var/sui/suidb /var/sui/db
```

### 7. Check the version 
```bash 
sui-node --version
```
### 8. Restart a node and check logs
```bash
sudo systemctl restart suid
```
```bash
journalctl -u suid -f
```
___
## Useful commands 
### 1. Check the version 
```bash
sui-node --version
```
### 2. Stop a node
```bash
sudo systemctl stop suid
```
### 3. Restart a node
```bash
sudo systemctl restart suid
```
### 4. Open logs
```bash
journalctl -u suid -f
```
___
### 5. Delete Sui node from your server 
```bash
sudo systemctl stop suid

sudo systemctl disable suid

sudo rm /etc/systemd/system/suid.service

sudo rm /usr/local/bin/sui

sudo rm /usr/local/bin/sui-node

sudo rm -rf $HOME/sui $HOME/.sui
```

[<img src = https://user-images.githubusercontent.com/80550154/228714104-060c73a2-01d9-44c9-8c06-c7b9218d42fd.png alt='banner' width= '99.9%'>]()
___
## About **Sui**
* **[Sui](https://sui.io/)** is a boundless platform to build rich and dynamic on-chain assets from gaming to finance.
* Sui is the first permissionless Layer 1 blockchain designed from the ground up to enable creators and developers to build experiences that cater to the next billion users in web3.
* The power of the sui element lies in its fluidity—its ability to easily adapt to and transform any environment. Similarly, the Sui platform seeks to provide a flexible network that you can leverage to shape the web3 landscape.

<font size = 4>**[Website](https://sui.io/) | [GitHub](https://github.com/MystenLabs/sui) | [Twitter](https://twitter.com/SuiNetwork) | [Discord](https://discord.gg/sui) | [Docs](https://docs.sui.io/) | [Whitepaper](https://github.com/MystenLabs/sui/blob/main/doc/paper/sui.pdf) | [Blog](https://medium.com/mysten-labs)**</font>
___

## Fullnode installation guide (permanent testnet)

### Navigation
* [Server requirements](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Sui/guidePT.md#server-requirements)
* [Insatll a fullnode on a clean machine](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Sui/guidePT.md#1-update-required-packages)
* [Monitore a fullnode performance](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Sui/guidePT.md#monitor-fullnode-performance)
* [Update a fullnode](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Sui/guidePT.md#update-a-fullnode)
* [Useful commands](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Sui/guide.md#useful-commands)
* [Fully remove a fullnode from the server](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Sui/guidePT.md#update-a-fullnode)
___
 ### _Sui Full nodes validate blockchain activities, including transactions, checkpoints, and epoch changes. Each Full node stores and services the queries for the blockchain state and history._
 ___

### `Server requirements`
```GO
OS: Ubuntu 20.04
CPUs: 10 core
RAM: 32 GB
Storage: 2 TB
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
mkdir $HOME/.sui
```
### 4. Clone a GitHub repository
```bash 
cd $HOME
git clone https://github.com/MystenLabs/sui.git
cd sui
git remote add upstream https://github.com/MystenLabs/sui
git fetch upstream
git checkout --track upstream/testnet
```
### 5. Copy a `fullnode.yaml` and the update path
```bash 
cp $HOME/sui/crates/sui-config/data/fullnode-template.yaml $HOME/.sui/fullnode.yaml

sed -i.bak "s|db-path:.*|db-path: \"$HOME\/.sui\/db\"| ; s|genesis-file-location:.*|genesis-file-location: \"$HOME\/.sui\/genesis.blob\"| ; s|127.0.0.1|0.0.0.0|" $HOME/.sui/fullnode.yaml
```
### 6. Download genesis.blob for testnet.
```bash
wget -P $HOME/.sui https://github.com/MystenLabs/sui-genesis/raw/main/testnet/genesis.blob
```
### 7. Compile `sui-node` and `sui` binaries
```bash
cargo build --release -p sui-node -p sui
```
### 8. `Move both binary files` to the right directory 
```bash
mv $HOME/sui/target/release/sui-node /usr/local/bin/
mv $HOME/sui/target/release/sui /usr/local/bin/
```

### 9. Create a service file
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
sudo systemctl daemon-reload
sudo systemctl enable suid
sudo systemctl start suid
```
```bash
journalctl -u suid -f
```
___
## Monitor fullnode performance 
### 1. Compare the number of checkpoints on your node and on chain
```bash
curl -q localhost:9184/metrics 2>/dev/null |grep '^highest_synced_checkpoint'; echo
```
```bash
curl --location --request POST 'https://fullnode.testnet.sui.io:443/' --header 'Content-Type: application/json' --data-raw '{"jsonrpc":"2.0", "id":1,"method":"sui_getLatestCheckpointSequenceNumber"}'; echo
```
### 2. Compare the number of transactions on your node and on chain
```bash
curl --location --request POST http://127.0.0.1:9000/ --header 'Content-Type: application/json' --data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionBlocks","id":1}'; echo 
```

```bash
curl --location --request POST https://fullnode.testnet.sui.io:443 --header 'Content-Type: application/json' --data-raw '{ "jsonrpc":"2.0", "method":"sui_getTotalTransactionBlocks","id":1}'; echo
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

git checkout -B testnet --track upstream/testnet
```
### 3. Compile binaries
```bash
cargo build --release -p sui-node -p sui
```
### 4. Move them to the right path
```bash
mv $HOME/sui/target/release/sui-node /usr/local/bin/
mv $HOME/sui/target/release/sui /usr/local/bin/
```

### 5. Check the version 
```bash 
sui-node --version
```
### 6. Restart the node and check logs
```bash
sudo systemctl restart suid
```
```bash
sudo journalctl -u suid -f
```
___
## Useful commands 
___
### Check the version 
```bash
sui-node --version
```
___
### Stop the node
```bash
sudo systemctl stop suid
```
___
### Restart the node
```bash
sudo systemctl restart suid
```
___
### Open logs
```bash
sudo journalctl -u suid -f
```
___
### Delete Sui node from the server 
```bash
sudo systemctl stop suid

sudo systemctl disable suid

sudo rm /etc/systemd/system/suid.service

sudo rm /usr/local/bin/sui

sudo rm /usr/local/bin/sui-node

sudo rm -rf $HOME/sui $HOME/.sui
```
___
### Check genesis.blob hash
```bash
sha256sum $HOME/.sui/genesis.blob
# The right output is
8286060d0a65c61b2eec105bf6f6ee6b8cc0626d7e6164cbd577b244c58db979 
```
___
### If your node is not syncing try adding peers into p2p config

```bash
sudo tee -a /root/.sui/fullnode.yaml << END

p2p-config:
  seed peers:
   - address: "/dns/sui-rpc-pt.testnet-pride.com/udp/8084"
   - address: "/dns/sui-rpc-testnet.bartestnet.com/udp/8084"
   - address: "/ip4/38.242.197.20/udp/8080"
   - address: "/ip4/178.18.250.62/udp/8080"
   - address: "/ip4/162.55.84.47/udp/8084"
   - address: "/dns/wave-3.testnet.n1stake.com/udp/8084"
END
```
```bash
sudo systemctl restart suid
```
___
[<img src='https://user-images.githubusercontent.com/83868103/227937841-6e05b933-9534-49f1-808a-efe087a4f7cd.png' alt='Twitter'  width='16.5%'>](https://twitter.com/intent/user?screen_name=TestnetPride&intent=follow)[<img src='https://user-images.githubusercontent.com/83868103/227935592-ea64badd-ceb4-4945-8dfc-f25c787fb29d.png' alt='TELEGRAM'  width='16.5%'>](https://t.me/TestnetPride)[<img src='https://user-images.githubusercontent.com/83868103/227936236-325bebfd-b287-4206-a964-dcbe67fe7ca8.png' alt='WEBSITE'  width='16.5%'>](http://testnet-pride.com/)[<img src='https://user-images.githubusercontent.com/83868103/227936479-a48e814b-3ec1-4dcb-bd44-96b02d8f55da.png' alt='MAIL'  width='16.5%'>](mailto:official@testnet-pride.com)[<img src='https://user-images.githubusercontent.com/83868103/227932993-b1e3a588-2b91-4915-854a-fa47da3b2cdb.png' alt='LINKEDIN'  width='16.5%'>](https://www.linkedin.com/company/testnet-pride/) [<img src='https://user-images.githubusercontent.com/83868103/227948915-65731f97-c406-4d2c-996c-e5440ff67584.png' alt='GITHUB'  width='16.5%'>](https://github.com/testnet-pride)

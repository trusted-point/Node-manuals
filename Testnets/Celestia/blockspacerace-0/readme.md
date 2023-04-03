[<img src='https://user-images.githubusercontent.com/80550154/229421912-3cb57de7-6254-4091-b0ab-eaf16de87551.png' alt='banner' width= '99.9%'>]()
___
## About **Celestia**

* **[Celestia](https://celestia.org/)** is a modular consensus and data network, built to enable anyone to easily deploy their own blockchain with minimal overhead.

* Celestia provides consensus and security on-demand, enabling anyone to deploy a blockchain without the overhead of bootstrapping a new consensus network.

* Blockchains built on top of Celestia do not rely on honest majority assumptions for state validity, meaning that they can interoperate with the highest security standards.

* Because Celestia does not validate transactions, its throughput is not bottlenecked by state execution like traditional blockchains. Thanks to a property of data availability sampling, Celestia’s throughput scales with the number of users. 

<font size = 4>**[Website](https://celestia.org/) | [GitHub](https://github.com/celestiaorg/docs) | [Twitter](https://twitter.com/CelestiaOrg) | [Discord](https://discord.gg/5FVvx3WGfa) | [Docs](https://docs.celestia.org/) | [Whitepaper](https://celestia.org/resources/#whitepapers) | [Blog](https://blog.celestia.org/) | [Careers](https://celestia.org/careers/)**</font>
___
## `Available Explorers`

[<img src='https://user-images.githubusercontent.com/80550154/227062135-32a189c0-47d7-4263-8034-9f7726808601.png' alt='mintscan'  width='33%'>](https://testnet.mintscan.io/celestia-incentivized-testnet) [<img src='https://user-images.githubusercontent.com/80550154/229426224-288277c5-cfa9-4c38-95bb-5ff8c41680a3.png' alt='exploreme'  width='33%'>](https://celestia.explorers.guru/)
___

## `Server requirements`
#### You will need to run a Consensus Full Node to connect your bidge node to it (In the guide will will run them on the same server)

> Bridge Node requirements
```GO
Memory: 8 GB RAM
CPU: 6 cores
Disk: 500 GB SSD Storage
Bandwidth: 1 Gbps for Download/100 Mbps for Upload
```
>Consensus Full Node requirements
```GO
Memory: 8 GB RAM
CPU: Quad-Core
Disk: 250 GB SSD Storage
Bandwidth: 1 Gbps for Download/100 Mbps for Upload
```
---
## 1. `Prepare your server`

### Update and install required packages
```bash
sudo apt update && sudo apt upgrade -y && \
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential git make ncdu -y
```
### Install `GO`
```bash
cd $HOME && \
ver="1.19.1" && \
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" && \
sudo rm -rf /usr/local/go && \
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" && \
rm "go$ver.linux-amd64.tar.gz" && \
```
### Add Go to `$PATH`
```bash
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile && \
source $HOME/.bash_profile && \
go version
```

## 2. Install and run `celestiaa-app`
### Clone `GitHub repo`
```bash
cd $HOME 
rm -rf celestia-app 
git clone https://github.com/celestiaorg/celestia-app.git 
```
### Build `celestiaa-app` binary
```bash
### make sure to use the last published version on Discord

cd $HOME/celestia-app
APP_VERSION=v0.12.2 
git checkout tags/$APP_VERSION -b $APP_VERSION 
sudo make install
celestia-appd version 
```
### Setup P2P networks
```bash
cd $HOME
rm -rf networks
git clone https://github.com/celestiaorg/networks.git
```
### Initialize your node for `blockspacerace-0` chain
```bash
### make sure you set your custom name

celestia-appd init "node-name" --chain-id blockspacerace-0
```
### Copy `genesis.json` file 
```bash
cp $HOME/networks/blockspacerace/genesis.json $HOME/.celestia-app/config
```
### Add peers to `config.toml`. You can find more peers [here](https://github.com/celestiaorg/networks/blob/master/blockspacerace/peers.txt) 
```bash
PERSISTENT_PEERS="be935b5942fd13c739983a53416006c83837a4d2@178.170.47.171:26656,cea09c9ac235a143d4b6a9d1ba5df6902b2bc2bd@95.214.54.28:20656,5c9cfba00df2aaa9f9fe26952e4bf912e3f1e8ee@195.3.221.5:26656,7b2f4cb70f04f2e9befb6ace66ce1ac7b3bea5b4@178.239.197.179:26656,7ee2ba21197d58679cfc1517b5bbc6465bed387a@65.109.67.25:26656,dc0656ab58280d641c8d10311d86627255bec8a1@148.251.85.27:26656,ccbd6262d0324e2e858594b639f4296cc4952c93@13.57.127.89:26656,a507b2bda6d2974c84ae1e8a8b788fc9e44d01f7@142.132.131.184:26656,9768290c60a746ee97ef1a5bcb8bee69066475e8@65.109.80.150:2600"

sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$PERSISTENT_PEERS\"/" $HOME/.celestia-app/config/config.toml
```
### Set pruning to `nothing` (recommended)
```bash
PRUNING="nothing"
sed -i -e "s/^pruning *=.*/pruning = \"$PRUNING\"/" $HOME/.celestia-app/config/app.toml
```
### Download snapshot for the quick sync
```bash
cd $HOME
rm -rf ~/.celestia-app/data
mkdir -p ~/.celestia-app/data
SNAP_NAME=$(curl -s https://snaps.qubelabs.io/celestia/ | \
    egrep -o ">blockspacerace.*tar" | tr -d ">")
wget -O - https://snaps.qubelabs.io/celestia/${SNAP_NAME} | tar xf - \
    -C ~/.celestia-app/data/
```
### Create a service file for celestia consensus node

```bash
sudo tee <<EOF >/dev/null /etc/systemd/system/celestia-appd.service
[Unit]
Description=celestia-appd Cosmos daemon
After=network-online.target
[Service]
User=$USER
ExecStart=$(which celestia-appd) start
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
### Start celestia-appd and check logs
```bash
sudo systemctl enable celestia-appd && systemctl restart celestia-appd && journalctl -u celestia-appd.service -f -o cat
```
### Check your sync status
```bash
curl -s localhost:26657/status | jq .result | jq .sync_info

### "catching_up": false means your node is synced
```
---
## 2. Install and run `bridge node`
### Clone `celestia-node` repo
```bash
cd $HOME 
git clone https://github.com/celestiaorg/celestia-node.git 
cd $HOME/celestia-node 
git checkout tags/v0.8.1 
```
### Build required bianry
```bash
make build 
sudo make install 
make cel-key 
```
### Create a key for the bridge node
> Your generated key will be stored in `$HOME/.celestia-bridge-blockspacerace-0/keys/keyring-test/`
```bash
cd $HOME/celestia-node
./cel-key add bridge_wallet --keyring-backend test --node.type bridge --p2p.network blockspacerace

### Save your seed phrase !!!
```
#### You can recover your old wallet (Optional)
```bash
cd $HOME/celestia-node/
./cel-key add bridge_wallet --keyring-backend test --node.type bridge --p2p.network blockspacerace --recover
```
---
### Request tokens on [Discord](https://discord.gg/celestiacommunity) and check your balance on the [explorer](https://testnet.mintscan.io/celestia-incentivized-testnet)
> To check your wallet address use 
```bash
cd $HOME/celestia-app
./cel-key list --node.type light --keyring-backend test --p2p.network blockspacerace
```
---

### Initialize your bridge node for `blockspacerace-0` chain
```bash
celestia bridge init --core.ip localhost  --core.grpc.port 9090 --p2p.network blockspacerace
```
---
### Check your grpc and rpc port which is used by **celestia-app**
(Here we use defult **9090** gRPC and **26657** RPC ports which you can edit in `$HOME/.celestia-app/config/app.toml`)

```bash
cat $HOME/.celestia-app/config/app.toml | sed -n '/\[grpc\]/,/address = /p' | grep -Ev "#|^$"
```
```bash
cat $HOME/.celestia-app/config/config.toml | sed -n '/\[rpc\]/,/laddr/p' | grep -Ev "#|^$"
```
---
### Create a service file for celestia consensus node (Note: with `--metrics.tls=false --metrics --metrics.endpoint otel.celestia.tools:4318` flags your bridge node will be pushing metrics to the [explorer](https://tiascan.com/) which is required for the incentivized testnet participants to gain point)
```bash
sudo tee <<EOF >/dev/null /etc/systemd/system/celestia-bridge.service
[Unit]
Description=celestia-bridge Cosmos daemon
After=network-online.target

[Service]
User=$USER
ExecStart=$(which celestia) bridge start --core.ip localhost --core.rpc.port 26657 --core.grpc.port 9090 --keyring.accname bridge_wallet --metrics.tls=false --metrics --metrics.endpoint otel.celestia.tools:4318 --gateway --gateway.addr localhost --gateway.port 26659 --p2p.network blockspacerace
ExecStart=
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```
### Start bridge node and check logs
```bash
sudo sudo systemctl enable celestia-bridge && systemctl restart celestia-bridge && journalctl -u celestia-bridge.service -f -o cat
```
---

## Get your **`Bridge Node ID`** to submit tasks and check it on the Explorer

### Gnerate your authorization token first
```bash
AUTH_TOKEN=$(celestia bridge auth admin --p2p.network blockspacerace) \
echo $AUTH_TOKEN
```
### Check your Bridge Node ID
```bash
curl -X POST \
>      -H "Authorization: Bearer $AUTH_TOKEN" \
>      -H 'Content-Type: application/json' \
>      -d '{"jsonrpc":"2.0","id":0,"method":"p2p.Info","params":[]}' \
>      http://localhost:26658
```
### Once your node is started it will be syncing and you should be able to check it on the [explorer](https://tiascan.com/bridge-nodes)
---
## **`Useful commands`**
### Download snapshot
```bash
cd $HOME
rm -rf ~/.celestia-app/data
mkdir -p ~/.celestia-app/data
SNAP_NAME=$(curl -s https://snaps.qubelabs.io/celestia/ | \
    egrep -o ">blockspacerace.*tar" | tr -d ">")
wget -O - https://snaps.qubelabs.io/celestia/${SNAP_NAME} | tar xf - \
    -C ~/.celestia-app/data/
```
---
> ### **State sync**
#### Stop the node
```bash
systemctl stop celestia-appd
```
#### Delete DB
```bash
celestia-appd tendermint unsafe-reset-all --home $HOME/.celestia-app --keep-addr-book
```
#### Set variables
```bash
SNAP_RPC="https://rpc-blockspacerace.pops.one:443"
LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 2000)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)
```
#### Edit config.toml
```bash
sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"|" $HOME/.celestia-app/config/config.toml
```
#### Restart the node
```bash
systemctl restart celestia-appd && journalctl -u celestia-appd.service -f -o cat
```
#### Disable state sync in `config.toml` to avoid issues during the next restart
```bash
sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1false|" $HOME/.celestia-app/config/config.toml
```
### Check sync status 
```bash
curl -s localhost:26657/status | jq .result | jq .sync_info

### "catching_up": false means your node is synced
```
---
## Get your `Bridge Node ID`
> ### Gnerate your authorization token first
```bash
AUTH_TOKEN=$(celestia bridge auth admin --p2p.network blockspacerace) \
echo $AUTH_TOKEN
```
### Check
```bash
curl -X POST \
>      -H "Authorization: Bearer $AUTH_TOKEN" \
>      -H 'Content-Type: application/json' \
>      -d '{"jsonrpc":"2.0","id":0,"method":"p2p.Info","params":[]}' \
>      http://localhost:26658
```
---
### Check bridge wallet balance 
```bash
curl -s http://localhost:26659/balance | jq
```
### Check the list of your wallets 
```bash
./cel-key list --node.type bridge --keyring-backend test --p2p.network blockspacerace
```
---
## Update your bridge node to the latest version
### Stop your bridge node
```bash
sudo systemctl stop celestia-bridge
```
### Check the latest `version` published on Discord and set the variable
```bash
### update with the lates one you want to update to
VERSION=v0.8.1
```
### Update `GitHub` repo
```bash
cd $HOME/celestia-node
git fetch
git checkout $VERSION
```
### Build a new `celestia` binary 
```bash
make build
sudo make install
```
### Remove `Database`
```bash
cd $HOME
cd .celestia-bridge-blockspacerace-0
sudo rm -rf blocks index data transients
```
### `Init` your bridge node:
```bash
celestia light init --p2p.network blockspacerace
```
### `Restart`
```bash
sudo sudo systemctl enable celestia-bridge && systemctl restart celestia-bridge && journalctl -u celestia-bridge.service -f -o cat
```
#

[<img src='https://user-images.githubusercontent.com/83868103/227937841-6e05b933-9534-49f1-808a-efe087a4f7cd.png' alt='Twitter'  width='16.5%'>](https://twitter.com/intent/user?screen_name=TestnetPride&intent=follow)[<img src='https://user-images.githubusercontent.com/83868103/227935592-ea64badd-ceb4-4945-8dfc-f25c787fb29d.png' alt='TELEGRAM'  width='16.5%'>](https://t.me/TestnetPride)[<img src='https://user-images.githubusercontent.com/83868103/227936236-325bebfd-b287-4206-a964-dcbe67fe7ca8.png' alt='WEBSITE'  width='16.5%'>](http://testnet-pride.com/)[<img src='https://user-images.githubusercontent.com/83868103/227936479-a48e814b-3ec1-4dcb-bd44-96b02d8f55da.png' alt='MAIL'  width='16.5%'>](mailto:official@testnet-pride.com)[<img src='https://user-images.githubusercontent.com/83868103/227932993-b1e3a588-2b91-4915-854a-fa47da3b2cdb.png' alt='LINKEDIN'  width='16.5%'>](https://www.linkedin.com/company/testnet-pride/)[<img src='https://user-images.githubusercontent.com/83868103/227948915-65731f97-c406-4d2c-996c-e5440ff67584.png' alt='GITHUB'  width='16.5%'>](https://github.com/testnet-pride)
___

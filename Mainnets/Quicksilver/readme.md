![Без имени-2](https://github.com/trusted-point/Node-manuals/assets/83868103/4b382903-c0ca-493c-bd5a-9221e9b4156e)


## [Quicksilver Protocol](https://quicksilver.zone/)
*The Liquid Staking Solution for the Cosmos Ecosystem*

### Features and Functionalities:
- **Liquid Staking**: Facilitates seamless asset transfers of staked positions. [Learn more](https://quicksilver.zone/)
- **Interchain Accounts (ICA)**: Enables control over stake accounts across IBC. [Details](https://docs.quicksilver.zone/)
- **Modules**: Including **[Interchain Staking](https://docs.quicksilver.zone/#/Interchain-Staking)**, **[Participation Rewards](https://docs.quicksilver.zone/#/Participation-Rewards)**, **[Claim Manager](https://docs.quicksilver.zone/#/Claim-Manager)**, and more.
- **Validator Documentation & IBC Channels**: Comprehensive guides for validators. [Validator Docs](https://docs.quicksilver.zone/#/Validator-Documentation)
- **Security**: Focus on security with audits and bug bounty programs. [Security Info](https://docs.quicksilver.zone/#/Audits)
- **QCK Token**: Serves for governance, securing the network, and transaction fees. [Token Utility](https://docs.quicksilver.zone/#/Token-Utility)

### Strategic Partnerships:
- Collaborations with entities like **[01node](https://01node.com/)**, **[Cerulean VC](https://cerulean.vc/)**, and others. [Partners](https://quicksilver.zone/#/Strategic-Partners)

### Application Interface:
- **Governance**: Participate in on-chain governance. [Governance Portal](https://app.quicksilver.zone/governance)
- **Staking Interface**: Delegate and manage staking. [Stake Here](https://app.quicksilver.zone/stake/delegate)
- **Airdrop**: Information about ongoing airdrops. [Airdrop Details](https://app.quicksilver.zone/airdrop)

### Additional Resources:
- **Documentation**: Extensive resources for understanding Quicksilver. [Docs](https://docs.quicksilver.zone/)
- **IBC Channels**: List of supported IBC clients, connections, and channels. [IBC Channels](https://docs.quicksilver.zone/#/IBC-Channels)

This compilation gives a detailed perspective of the Quicksilver protocol, its ecosystem, and functionalities, with direct links for deeper exploration.

___
## **Navigation**

* [Validator installation guide](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#prepare-a-server)
  * [Variables](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#variables)
  * [Build and configuration](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#build-and-configuration)
  * [Change ports](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#change-port)
  * [Memory optimization](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#memory-optimization)
  * [State-sync synchronization](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#state-sync-synchronization)
  * [Start a node](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#start-node)
  * [Create a validator](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#create-a-validator)
  * [Update a validator](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#update-node)
* [Useful commands](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#node-status)
  * [Node status](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#node-status)
  * [Validator info](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#validator-info)
  * [Wallet](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#wallet)
  * [Voting](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#voting)
  * [Actions](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#actions)
  * [All validators info](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#all-validators-info)
  * [Useful commands](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#useful-commands-1)
* [Delete a node](https://github.com/trusted-point/Node-manuals/blob/main/Mainnets/Quicksilver/readme.md#delete-a-node)
___
## Available Explorers

[<img src='https://user-images.githubusercontent.com/80550154/227062135-32a189c0-47d7-4263-8034-9f7726808601.png' alt='mintscan'  width='33%'>](https://www.mintscan.io/quicksilver) [<img src='https://user-images.githubusercontent.com/80550154/229426224-288277c5-cfa9-4c38-95bb-5ff8c41680a3.png' alt='guru'  width='33%'>](https://quicksilver.explorers.guru/) [<img src='https://user-images.githubusercontent.com/80550154/227062134-d4717597-59c8-47fb-96ed-416d4276a7bc.png' alt='exploreme'  width='33%'>](https://quicksilver.exploreme.pro/)
___
## Prepare a server
```python
UPDATE AND INSTALL PACKAGES
```
```bash
sudo apt update && sudo apt upgrade -y && \
sudo apt install curl tar wget clang pkg-config libssl-dev libleveldb-dev jq build-essential bsdmainutils git make ncdu htop screen unzip bc fail2ban htop -y
```
```python
INSTALLING GO v1.20
```
```bash
cd $HOME && \
ver="1.20" && \
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" && \
sudo rm -rf /usr/local/go && \
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" && \
rm "go$ver.linux-amd64.tar.gz" && \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile && \
source $HOME/.bash_profile && \
go version
```
___
## Variables
```python
CHANGE VARIABLES
```
```bash
MONIKER="<YOUR_NEW_MONIKER>"
WALLET="<YOUR_WALLET_NAME>"
WEBSITE="<YOUR_WEBSITE>"
IDENTITY="<<YOUR_KEYBASE_ID>"
DETAILS='"<YOUR_DESCRIPTION>"'
SECURITY_CONTACT="<YOUR_EMAIL>"
```
```python
SET VARIABLES 
```
```bash
echo "export MONIKER=$MONIKER" >> $HOME/.bash_profile && \
echo "export WALLET=$WALLET" >> $HOME/.bash_profile && \
echo "export WEBSITE=$WEBSITE" >> $HOME/.bash_profile && \
echo "export IDENTITY=$IDENTITY" >> $HOME/.bash_profile && \
echo "export DETAILS=$DETAILS" >> $HOME/.bash_profile && \
echo "export SECURITY_CONTACT=$SECURITY_CONTACT" >> $HOME/.bash_profile && \
source $HOME/.bash_profile
```
___
## Build and configuration
```python
BUILD BINARY
```
```bash
git clone https://github.com/quicksilver-zone/quicksilver.git quicksilver && \
cd quicksilver && \
git checkout v1.2.17 && \
make install
quicksilverd version --long | grep -e version -e commit
# version: 1.2.17
```
#
```python
CONFIGURATION
```
```bash 
quicksilverd init $MONIKER --chain-id quicksilver-2 && \
quicksilverd config chain-id quicksilver-2 && \
quicksilverd config keyring-backend os
```
#
```python
ADD NEW WALLET OR RESTORE OLD WALLET
```
```bash
quicksilverd keys add $WALLET
```
```bash
quicksilverd keys add $WALLET --recover
```
#
```python
SET VARIABLES 
```
```bash
VALOPER=$(quicksilverd keys show $WALLET --bech val -a) # ENTER PASSWORD
```
```bash
ADDRESS=$(quicksilverd keys show $WALLET --address) # ENTER PASSWORD
```
```bash
echo "export VALOPER=$VALOPER" >> $HOME/.bash_profile && \
echo "export ADDRESS=$ADDRESS" >> $HOME/.bash_profile && \
source $HOME/.bash_profile
```
#
```python
ADD PEERS AND SEEDS
```
```bash
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"6053a39e67c6bae83430e354f53d99e160e4964b@65.109.28.177:28656\"/;
s/^seeds *=.*/seeds = \"$SEEDS\"/" $HOME/.quicksilverd/config/config.toml
```
#
```python
DOWNLOAD GENESIS 
```
```bash
wget -O $HOME/.quicksilverd/config/genesis.json https://raw.githubusercontent.com/trusted-point/Node-manuals/main/Mainnets/Quicksilver/genesis.json
```

```python
DOWNLOAD ADDRBOOK
```
```bash
wget -qO $HOME/.quicksilverd/config/addrbook.json https://raw.githubusercontent.com/trusted-point/Node-manuals/main/Mainnets/Quicksilver/addrbook.json
```
___
## Change PORT
```python
CHANGE VARIABLES # CURRENT VARIABLE IS DEFAULT PORTS
```
```bash
NODES_NUM="0"
```
#
```python
CHANGING PORTS
```
```bash
sed -i.bak -e "\
s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:$((NODES_NUM+26))658\"%; \
s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://0.0.0.0:$((NODES_NUM+26))657\"%; \
s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:$((NODES_NUM+6))060\"%; \
s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:$((NODES_NUM+26))656\"%; \
s%^external_address = \"\"%external_address = \"`echo $(wget -qO- eth0.me):$((NODES_NUM+26))656`\"%; \
s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":$((NODES_NUM+26))660\"%" $HOME/.quicksilverd/config/config.toml
```
```bash
sed -i.bak -e "\
s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:$((NODES_NUM+1))317\"%; \
s%^address = \":8080\"%address = \":$((NODES_NUM+8))080\"%; \
s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:$((NODES_NUM+9))090\"%; \
s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:$((NODES_NUM+9))091\"%" $HOME/.quicksilverd/config/app.toml
```
```bash
echo "export NODE=http://localhost:$((NODES_NUM+26))657" >> $HOME/.bash_profile && \
source $HOME/.bash_profile && \
quicksilverd config node $NODE
```
___
## Memory optimization
```python
CHANGE VARIABLES # CURRENT VARIABLES ARE PREFERRED
```
```bash 
indexer="null" && \
min_retain_blocks=1 && \
snapshot_interval="100" && \
pruning="custom" && \
pruning_keep_recent="100" && \
pruning_keep_every="0" && \
pruning_interval="10" && \
min_retain_blocks="1" && \
inter_block_cache="false" 
```
#
```python
SET VARIABLES 
```
```bash
sed -i.bak -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.quicksilverd/config/config.toml && \
sed -i.bak -e "s/^min-retain-blocks *=.*/min-retain-blocks = \"$min_retain_blocks\"/" $HOME/.quicksilverd/config/app.toml && \
sed -i.bak -e "s/^snapshot-interval *=.*/snapshot-interval = \"$snapshot_interval\"/" $HOME/.quicksilverd/config/app.toml && \
sed -i.bak -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.quicksilverd/config/app.toml && \
sed -i.bak -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.quicksilverd/config/app.toml && \
sed -i.bak -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.quicksilverd/config/app.toml && \
sed -i.bak -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.quicksilverd/config/app.toml && \
sed -i.bak -e "s/^min-retain-blocks *=.*/min-retain-blocks = \"$min_retain_blocks\"/" $HOME/.quicksilverd/config/app.toml && \
sed -i.bak -e "s/^inter-block-cache *=.*/inter-block-cache = \"$inter_block_cache\"/" $HOME/.quicksilverd/config/app.toml
```
___
## State-sync synchronization
```python
CHANGE VARIABLES 
```
```bash
RPC=http://rpc-quicksilver-main.trusted-point.com:443
```
```python
SET VARIABLES 
```
```bash
LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 100)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

echo $LATEST_HEIGHT $BLOCK_HEIGHT $TRUST_HASH

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"| ; \
s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"\"|" $HOME/.quicksilverd/config/config.toml
```
___
## Start node
```python
CREATE SERVICE 
```
```bash
sudo tee /etc/systemd/system/quicksilverd.service > /dev/null <<EOF
[Unit]
Description=Quicksilver Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which quicksilverd) start
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```
#
```python
START SERVICE 
```
```bash
sudo systemctl daemon-reload && \
sudo systemctl enable archwayd && \
sudo systemctl restart archwayd && \
sudo journalctl -u quicksilverd -f -o cat
```
___

## Create a validator
```python
CHECK SYNCHRONIZATION OF YOUR NODE # IF THE RESULT IS FALSE, THE NODE IS SYNCHRONIZED
```
```bash
curl -s $NODE/status | jq .result.sync_info.catching_up
```
#
```python
CHECK BALANCE # MINIMUM QUANTITY TO CREATE A VALIDATOR 1000000
```
```bash
quicksilverd q bank balances $ADDRESS
```
#
```python
CREATE A VALIDATOR
```
```bash 
quicksilverd tx staking create-validator \
  --amount=1000000uqck \
  --pubkey=$(quicksilverd tendermint show-validator) \
  --moniker=$MONIKER \
  --chain-id=quicksilver-2 \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation=1000000 \
  --fees=200uqck \
  --from=$WALLET \
  --identity=$IDENTITY \
  --website=$WEBSITE \
  --details=$DETAILS \
  --security-contact=$SECURITY_CONTACT \
  -y
  ```
___

## Update node
```python
CHANGE VARIABLES # EXAMPLE v.1.2.1
```
```bash
TAG_NAME=""
```
#
```python
UPDATE NODE
```
```bash
sudo systemctl stop quicksilverd && \
cd quicksilver && \
git pull; \
git checkout tags/$TAG_NAME && \
make clean; \
make install && \
sudo systemctl restart quicksilverd && \
journalctl -u quicksilverd -f -o cat
```
___
## USEFUL COMMANDS

### Node status

```python
SERVICE LOGS
```
```bash
journalctl -u quicksilverd -f -o cat
```
#
```python
SERVICE STATUS
```
```bash
systemctl status quicksilverd
```
#
```python
CHECK NODE STATUS
```
```bash
curl -s $NODE/status
```
#
```python
CHECK SYNCHRONIZATION OF YOUR NODE # IF THE RESULT IS FALSE, THE NODE IS SYNCHRONIZED
```
```bash
curl -s $NODE/status | jq .result.sync_info.catching_up
```
#
```python
CHECK CONSENSUS 
```
```bash
curl -s $NODE/consensus_state  | jq '.result.round_state.height_vote_set[0].prevotes_bit_array'
```
#
```python
CONNECTED PEERS
```
```bash
curl -s $NODE/net_info | jq -r '.result.peers[] | "\(.node_info.id)@\(.remote_ip):\(.node_info.listen_addr | split(":")[2])"' | wc -l
```
___
### Validator info

```python
GET VALIDATOR ADDRESS 
```
```bash
echo $VALOPER
```
#
```python
GET WALLET ADDRESS
```
```bash
echo $ADDRESS
```
#
```python
JAIL, TOMBSTONED, START_HEIGHT, INDEX_OFFSET
```
```bash
quicksilverd q slashing signing-info $(quicksilverd tendermint show-validator)
```
#
```python
GET PEER 
```
```bash
echo "$(quicksilverd tendermint show-node-id)@$(curl ifconfig.me):$(curl -s $NODE/status | jq -r '.result.node_info.listen_addr' | cut -d':' -f3)"
```
### Wallet
```python
GET BALANCE
```
```bash
quicksilverd q bank balances $ADDRESS
```
___
### Voting
```python
VOTE
```
```bash
quicksilverd tx gov vote <PROPOSAL_ID> <yes|no> --from $WALLET --fees 200uqck -y
```
#
```python
CHECK ALL VOTED PROPOSALS
```
```bash
quicksilverd q gov proposals --voter $ADDRESS
```
___
### Actions
```python
EDIT VALIDATOR
```
```bash
quicksilverd tx staking edit-validator --website="<YOUR_WEBSITE>" --details="<YOUR_DESCRIPTION>" --moniker="<YOUR_NEW_MONIKER>" --from=$WALLET --fees 200uqck
```
#
```python
UNJAIL
```
```bash
quicksilverd tx slashing unjail --from $WALLET --fees 200uqck
```
#
```python
BOND MORE TOKENS (IF YOU WANT INCREASE YOUR VALIDATOR STAKE YOU SHOULD BOND MORE TO YOUR VALOPER ADDRESS):
```
```bash
quicksilverd tx staking delegate $VALOPER <TOKENS_COUNT>uconst--from $WALLET --fees 200uqck -y
```
#
```python
UNDELEGATE
```
```bash
quicksilverd tx staking unbond $VALOPER <TOKENS_COUNT>uqck --from $WALLET --fees 200uqck -y
```
#
```python
SEND TOKENS. 1 TOKEN = 1000000 (COSMOS)
```
```bash
quicksilverd tx bank send $WALLET <WALLET_TO> <TOKENS_COUNT>uqck --fees 200uqck --gas auto
```
#
```python
CHANGE PEERS AND SEEDS
```
```bash
peers="<PEERS>"
seeds="<SEEDS>"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/; s/^seeds *=.*/seeds = \"$seeds\"/" $HOME/.quicksilverd/config/config.toml
```
#
```python
RESET PRIVATE VALIDATOR FILE TO GENESIS STATE AND DELETE ADDRBOOK.JSON
```
```bash
quicksilverd tendermint unsafe-reset-all --home $HOME/.quicksilverd
```
___
### All validators info
```python
LIST OF ALL ACTIVE VALIDATORS 
```
```bash
quicksilverd q staking validators -o json --limit=1000 \
| jq '.validators[] | select(.status=="BOND_STATUS_BONDED")' \
| jq -r '.tokens + " - " + .description.moniker' \
| sort -gr | nl
```
#
```python
LIST OF ALL INACTIVE VALIDATORS 
```
```bash
quicksilverd q staking validators -o json --limit=1000 \
| jq '.validators[] | select(.status=="BOND_STATUS_UNBONDED")' \
| jq -r '.tokens + " - " + .description.moniker' \
| sort -gr | nl
```
___
### Useful commands
```python
ROOT → YOUR NODE
```
```bash
su -l $USER_NAME
```
#
```python
CHECK INTERNET CONNECTION
```
```bash
curl -sL yabs.sh | bash -s -- -fg
```
#
```python
SERVER LOAD
```
```bash
sudo htop
```
#
```python
FILE STRUCTURE
```
```bash
ncdu
```
___
## Delete a node
```python
USE COMMAND
```
```bash
sudo systemctl stop quicksilverd && \
sudo systemctl disable quicksilverd; \
sudo rm /etc/systemd/system/quicksilverd.service; \
sudo systemctl daemon-reload && \

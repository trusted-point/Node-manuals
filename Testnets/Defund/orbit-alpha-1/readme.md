## Prepare a server
```python
UPDATE AND INSTALL PACKAGES
```
```bash
sudo apt update && sudo apt upgrade -y && \
sudo apt install curl tar wget clang pkg-config libssl-dev libleveldb-dev jq build-essential bsdmainutils git make ncdu htop screen unzip bc fail2ban htop -y
```
```python
INSTALLING GO v1.19.4
```
```bash
cd $HOME && \
ver="1.19.4" && \
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
git clone https://github.com/defund-labs/defund.git defund && \
cd defund && \
git checkout v0.2.6 && \
make install
defundd version --long | grep -e version -e commit
# version: 0.2.6
# commit: 8f2ebe3d30efe84e013ec5fcdf21a3b99e786c3d
```
#
```python
CONFIGURATION
```
```bash 
defundd init $MONIKER --chain-id orbit-alpha-1 && \
defundd config chain-id orbit-alpha-1 && \
defundd config keyring-backend os
```
#
```python
ADD NEW WALLET OR RESTORE OLD WALLET
```
```bash
archwayd keys add $WALLET
```
```bash
archwayd keys add $WALLET --recover
```
#
```python
SET VARIABLES 
```
```bash
VALOPER=$(archwayd keys show $WALLET --bech val -a) # ENTER PASSWORD
```
```bash
ADDRESS=$(archwayd keys show $WALLET --address) # ENTER PASSWORD
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
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"5c10d3d84adb970474eff3c9b5d8fe50fd2dbbfb@144.76.18.199:26656,802993601906fae95a19e96f2e8bd538b0d209d5@35.222.155.3:26656,1570fd9b344af3bf77ec7eefffe485033f412080@65.109.112.178:26656,a2ad516c5301fb1a9793b0c9bd2195e16721ed73@34.170.18.34:26656\"/; s/^seeds *=.*/seeds = \"$SEEDS\"/" $HOME/.archway/config/config.toml
```
#
```python
DOWNLOAD GENESIS 
```
```bash
wget -O $HOME/.archway/config/genesis.json https://raw.githubusercontent.com/defund-labs/testnet/main/orbit-alpha-1/genesis.json
```

```python
DOWNLOAD ADDRBOOK
```
```bash
wget -qO $HOME/.archway/config/addrbook.json http://94.250.203.6:90/constantine-2.addr.json
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
s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":$((NODES_NUM+26))660\"%" $HOME/.archway/config/config.toml
```
```bash
sed -i.bak -e "\
s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:$((NODES_NUM+1))317\"%; \
s%^address = \":8080\"%address = \":$((NODES_NUM+8))080\"%; \
s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:$((NODES_NUM+9))090\"%; \
s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:$((NODES_NUM+9))091\"%" $HOME/.archway/config/app.toml
```
```bash
echo "export NODE=http://localhost:$((NODES_NUM+26))657" >> $HOME/.bash_profile && \
source $HOME/.bash_profile && \
archwayd config node $NODE
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
sed -i.bak -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.archway/config/config.toml && \
sed -i.bak -e "s/^min-retain-blocks *=.*/min-retain-blocks = \"$min_retain_blocks\"/" $HOME/.archway/config/app.toml && \
sed -i.bak -e "s/^snapshot-interval *=.*/snapshot-interval = \"$snapshot_interval\"/" $HOME/.archway/config/app.toml && \
sed -i.bak -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.archway/config/app.toml && \
sed -i.bak -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.archway/config/app.toml && \
sed -i.bak -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.archway/config/app.toml && \
sed -i.bak -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.archway/config/app.toml && \
sed -i.bak -e "s/^min-retain-blocks *=.*/min-retain-blocks = \"$min_retain_blocks\"/" $HOME/.archway/config/app.toml && \
sed -i.bak -e "s/^inter-block-cache *=.*/inter-block-cache = \"$inter_block_cache\"/" $HOME/.archway/config/app.toml
```
___
## State-sync synchronization
```python
CHANGE VARIABLES 
```
```bash
RPC=http://rpc-archway.testnet-pride.com:40657
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
s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"\"|" $HOME/.archway/config/config.toml
```
___
## Start node
```python
CREATE SERVICE 
```
```bash
sudo tee /etc/systemd/system/archwayd.service > /dev/null <<EOF
[Unit]
Description=Archway Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which archwayd) start
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
sudo journalctl -u archwayd -f -o cat
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
archwayd q bank balances $ADDRESS
```
#
```python
CREATE A VALIDATOR
```
```bash 
archwayd tx staking create-validator \
  --amount=1000000uconst \
  --pubkey=$(archwayd tendermint show-validator) \
  --moniker=$MONIKER \
  --chain-id=constantine-2 \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation=1000000 \
  --fees=200uconst \
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
sudo systemctl stop archwayd && \
cd archway && \
git pull; \
git checkout tags/$TAG_NAME && \
make clean; \
make install && \
sudo systemctl restart archwayd && \
journalctl -u archwayd -f -o cat
```
___
## USEFUL COMMANDS

### Node status

```python
SERVICE LOGS
```
```bash
journalctl -u archwayd -f -o cat
```
#
```python
SERVICE STATUS
```
```bash
systemctl status archwayd
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
archwayd q slashing signing-info $(archwayd tendermint show-validator)
```
#
```python
GET PEER 
```
```bash
echo "$(archwayd tendermint show-node-id)@$(curl ifconfig.me):$(curl -s $NODE/status | jq -r '.result.node_info.listen_addr' | cut -d':' -f3)"
```
### Wallet
```python
GET BALANCE
```
```bash
archwayd q bank balances $ADDRESS
```
___
### Voting
```python
VOTE
```
```bash
archwayd tx gov vote <PROPOSAL_ID> <yes|no> --from $WALLET --fees 200uconst -y
```
#
```python
CHECK ALL VOTED PROPOSALS
```
```bash
archwayd q gov proposals --voter $ADDRESS
```
___
### Actions
```python
EDIT VALIDATOR
```
```bash
archwayd tx staking edit-validator --website="<YOUR_WEBSITE>" --details="<YOUR_DESCRIPTION>" --moniker="<YOUR_NEW_MONIKER>" --from=$WALLET --fees 200uconst
```
#
```python
UNJAIL
```
```bash
archwayd tx slashing unjail --from $WALLET --fees 200uconst
```
#
```python
BOND MORE TOKENS (IF YOU WANT INCREASE YOUR VALIDATOR STAKE YOU SHOULD BOND MORE TO YOUR VALOPER ADDRESS):
```
```bash
archwayd tx staking delegate $VALOPER <TOKENS_COUNT>uconst--from $WALLET --fees 200uconst -y
```
#
```python
UNDELEGATE
```
```bash
archwayd tx staking unbond $VALOPER <TOKENS_COUNT>uconst --from $WALLET --fees 200uconst -y
```
#
```python
SEND TOKENS. 1 TOKEN = 1000000 (COSMOS)
```
```bash
archwayd tx bank send $WALLET <WALLET_TO> <TOKENS_COUNT>uconst --fees 200uconst --gas auto
```
#
```python
CHANGE PEERS AND SEEDS
```
```bash
peers="<PEERS>"
seeds="<SEEDS>"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/; s/^seeds *=.*/seeds = \"$seeds\"/" $HOME/.archway/config/config.toml
```
#
```python
RESET PRIVATE VALIDATOR FILE TO GENESIS STATE AND DELETE ADDRBOOK.JSON
```
```bash
archwayd tendermint unsafe-reset-all --home $HOME/.archway
```
___
### All validators info
```python
LIST OF ALL ACTIVE VALIDATORS 
```
```bash
archwayd q staking validators -o json --limit=1000 \
| jq '.validators[] | select(.status=="BOND_STATUS_BONDED")' \
| jq -r '.tokens + " - " + .description.moniker' \
| sort -gr | nl
```
#
```python
LIST OF ALL INACTIVE VALIDATORS 
```
```bash
archwayd q staking validators -o json --limit=1000 \
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
sudo systemctl stop archwayd && \
sudo systemctl disable archwayd; \
sudo rm /etc/systemd/system/archwayd.service; \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .archway archway; \
sudo rm $(which archwayd)
```

___
## Prepare
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
git clone https://github.com/archway-network/archway.git archway && \
cd archway && \
git checkout v0.2.0 && \
make install
```
#
```python
CONFIGURATION
```
```bash 
canined init $MONIKER --chain-id jackal-1 && \
canined config chain-id jackal-1 && \
canined config keyring-backend os
```
#
```python
ADD NEW WALLET OR RESTORE OLD WALLET
```
```bash
canined keys add $WALLET
```
```bash
canined keys add $WALLET --recover
```
#
```python
SET VARIABLES 
```
```bash
VALOPER=$(canined keys show $WALLET --bech val -a) # ENTER PASSWORD
```
```bash
ADDRESS=$(canined keys show $WALLET --address) # ENTER PASSWORD
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
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"26175f13ada3d61c93bca342819fd5dc797bced0@teritori.nodejumper.io:28656,722b63e6c65628b929f22013dcbcde980210cb44@176.9.127.54:26656,8f28518afd31a42ea81bb3232a50ab0cec4dcdf7@51.158.236.131:26656,647bbbc30d26fbbb2f7d19aafe30ed77a92c4748@[2a01:4f9:6b:2e5b::4]:26656,5a98d637a16b16bf425a4a785c9d11a7d1e5b8a0@65.21.131.215:26736,f813a00f52de54a49aea3211b89a65ae6133eac2@88.99.167.148:26686,358f13bd95d91517053a58f4d30205842672837f@104.37.187.214:60656,ce3baba928ae06cd3ff0af20aec888a82ddffef7@54.37.129.171:26656,3bd3a20d7c8a26a20927289a7a6bffecf71de53e@51.81.155.97:10856,48980875839186e08e12ebf0d9a2803b45206833@65.109.92.241:38026,526d8c7c44f59be9a39d7463c576b68c0db23174@65.108.234.23:15956\"/; s/^seeds *=.*/seeds = \"$SEEDS\"/" $HOME/.canine/config/config.toml
```
#
```python
DOWNLOAD GENESIS 
```
```bash
wget -O $HOME/.canine/config/genesis.json https://cdn.discordapp.com/attachments/1002389406650466405/1034968352591986859/updated_genesis2.json
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
s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":$((NODES_NUM+26))660\"%" $HOME/.canine/config/config.toml
```
```bash
sed -i.bak -e "\
s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:$((NODES_NUM+1))317\"%; \
s%^address = \":8080\"%address = \":$((NODES_NUM+8))080\"%; \
s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:$((NODES_NUM+9))090\"%; \
s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:$((NODES_NUM+9))091\"%" $HOME/.canine/config/app.toml
```
```bash
echo "export NODE=http://localhost:$((NODES_NUM+26))657" >> $HOME/.bash_profile && \
source $HOME/.bash_profile && \
canined config node $NODE
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
sed -i.bak -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.canine/config/config.toml && \
sed -i.bak -e "s/^min-retain-blocks *=.*/min-retain-blocks = \"$min_retain_blocks\"/" $HOME/.canine/config/app.toml && \
sed -i.bak -e "s/^snapshot-interval *=.*/snapshot-interval = \"$snapshot_interval\"/" $HOME/.canine/config/app.toml && \
sed -i.bak -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.canine/config/app.toml && \
sed -i.bak -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.canine/config/app.toml && \
sed -i.bak -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.canine/config/app.toml && \
sed -i.bak -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.canine/config/app.toml && \
sed -i.bak -e "s/^min-retain-blocks *=.*/min-retain-blocks = \"$min_retain_blocks\"/" $HOME/.canine/config/app.toml && \
sed -i.bak -e "s/^inter-block-cache *=.*/inter-block-cache = \"$inter_block_cache\"/" $HOME/.canine/config/app.toml
```
___
## Start node
```python
CREATE SERVICE 
```
```bash
sudo tee /etc/systemd/system/canined.service > /dev/null <<EOF
[Unit]
Description=Canine Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=$(which canined) start
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
sudo systemctl enable canined && \
sudo systemctl restart canined && \
sudo journalctl -u canined -f -o cat
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
canined q bank balances $ADDRESS
```
#
```python
CREATE A VALIDATOR
```
```bash 
canined tx staking create-validator \
  --amount=1000000ujkl \
  --pubkey=$(canined tendermint show-validator) \
  --moniker=$MONIKER \
  --chain-id=jackal-1 \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation=1000000 \
  --fees=200ujkl \
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
sudo systemctl stop canined && \
cd canine && \
git pull; \
git checkout tags/$TAG_NAME && \
make clean; \
make install && \
sudo systemctl restart canined && \
journalctl -u canined -f -o cat
```
___
## USEFUL COMMANDS

### Node status

```python
SERVICE LOGS
```
```bash
journalctl -u canined -f -o cat
```
#
```python
SERVICE STATUS
```
```bash
systemctl status canined
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
canined q slashing signing-info $(canined tendermint show-validator)
```
#
```python
GET PEER 
```
```bash
echo "$(canined tendermint show-node-id)@$(curl ifconfig.me):$(curl -s $NODE/status | jq -r '.result.node_info.listen_addr' | cut -d':' -f3)"
```
### Wallet
```python
GET BALANCE
```
```bash
canined q bank balances $ADDRESS
```
___
### Voting
```python
VOTE
```
```bash
canined tx gov vote <PROPOSAL_ID> <yes|no> --from $WALLET --fees 200ujkl -y
```
#
```python
CHECK ALL VOTED PROPOSALS
```
```bash
canined q gov proposals --voter $ADDRESS
```
___
### Actions
```python
EDIT VALIDATOR
```
```bash
canined tx staking edit-validator --website="<YOUR_WEBSITE>" --details="<YOUR_DESCRIPTION>" --moniker="<YOUR_NEW_MONIKER>" --from=$WALLET --fees 200ujkl
```
#
```python
UNJAIL
```
```bash
canined tx slashing unjail --from $WALLET --fees 200ujkl
```
#
```python
BOND MORE TOKENS (IF YOU WANT INCREASE YOUR VALIDATOR STAKE YOU SHOULD BOND MORE TO YOUR VALOPER ADDRESS):
```
```bash
canined tx staking delegate $VALOPER <TOKENS_COUNT>ujkl--from $WALLET --fees 200ujkl -y
```
#
```python
UNDELEGATE
```
```bash
canined tx staking unbond $VALOPER <TOKENS_COUNT>ujkl --from $WALLET --fees 200ujkl -y
```
#
```python
SEND TOKENS. 1 TOKEN = 1000000 (COSMOS)
```
```bash
canined tx bank send $WALLET <WALLET_TO> <TOKENS_COUNT>ujkl --fees 200ujkl --gas auto
```
#
```python
CHANGE PEERS AND SEEDS
```
```bash
peers="<PEERS>"
seeds="<SEEDS>"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/; s/^seeds *=.*/seeds = \"$seeds\"/" $HOME/.canine/config/config.toml
```
#
```python
RESET PRIVATE VALIDATOR FILE TO GENESIS STATE AND DELETE ADDRBOOK.JSON
```
```bash
canined tendermint unsafe-reset-all --home $HOME/.canine
```
___
### All validators info
```python
LIST OF ALL ACTIVE VALIDATORS 
```
```bash
canined q staking validators -o json --limit=1000 \
| jq '.validators[] | select(.status=="BOND_STATUS_BONDED")' \
| jq -r '.tokens + " - " + .description.moniker' \
| sort -gr | nl
```
#
```python
LIST OF ALL INACTIVE VALIDATORS 
```
```bash
canined q staking validators -o json --limit=1000 \
| jq '.validators[] | select(.status=="BOND_STATUS_UNBONDED")' \
| jq -r '.tokens + " - " + .description.moniker' \
| sort -gr | nl
```
___
### Another useful commands
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
## Delete node
```python
USE COMMAND
```
```bash
sudo systemctl stop canined && \
sudo systemctl disable canined; \
sudo rm /etc/systemd/system/canined.service; \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .canine canine; \
sudo rm $(which canined)
```

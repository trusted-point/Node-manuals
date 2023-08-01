[<img src='https://github.com/Hacker-web-Vi/Hacker-web-Vi/assets/80550154/93b55c6a-0e89-46ce-99ac-14cde1a20421' alt='banner' width= '99.9%'>]()
## About **ZetaChain**
* **[ZetaChain](https://www.zetachain.com/)** is the foundational, public blockchain that enables omnichain, generic smart contracts and messaging between any blockchain. It solves the problems of “cross-chain” and “multi-chain” and aims to open the crypto and global financial ecosystem to anyone. ZetaChain envisions and supports a truly fluid, multi-chain crypto ecosystem, where users and developers can move between and appreciate the benefits of any blockchain: payments, DeFi, liquidity, games, art, social graphs, performance, security, privacy, and so on.

* ZetaChain is a decentralized and public blockchain network. It is built on Cosmos SDK and Tendermint Consensus. While many cross-chain solutions like bridges have varying, often centralized trust models that have a track record for being susceptible to exploits and hacks, ZetaChain is a Proof-of-Stake blockchain, where all transactions and activity on the platform -- even cross-chain transactions -- are fully transparent, verifiable, and function in a trust-minimized manner.

* ZetaChain's nodes have observers that monitor transactions on every connected chain. Through ZetaChain's TSS architecture, the network can sign and verify transactions on every connected chain as a wallet can. By being able to read and write to connected chains in a secure, decentralized manner, these hyper-connected nodes provide a seamless omnichain environment for developers to build novel and powerful cross-chain applications on top of.

<font size = 4>**[Website](https://www.zetachain.com/) | [GitHub](https://github.com/zeta-chain) | [Twitter](https://twitter.com/zetablockchain) | [Discord](https://discord.com/invite/zetachain) | [Docs](https://www.zetachain.com/docs/) | [Whitepaper](https://www.zetachain.com/whitepaper.pdf) | [Blog](https://www.zetachain.com/blog)**</font>
___
## **Navigation**

* [TestnetPride services (RPC, API)](https://github.com/Hacker-web-Vi/Hacker-web-Vi/assets/80550154/93b55c6a-0e89-46ce-99ac-14cde1a20421)
* [State Sync](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#state-sync-synchronization)
  * [Install required packages and Go](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#prepare-the-server)
  * [Set variables](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#set-variables)
  * [Download pre-built zeta binary](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#download-the-binary)
  * [Download config](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#download-configs)
  * [Disk space optimization](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#disk-space-optimization--following-variables-can-be-customised)
  * [State sync](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#state-sync-synchronization)
  * [Start the node](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#start-the-node)
  * [Create a validator](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#create-a-validator)
* [Useful commands](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#useful-commands)
  * [Node status](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#node-status)
  * [Voting](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#voting-for-the-proposal)
  * [All validators info](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#all-validators-info)
* [Useful commands](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#useful-commands)
* [Delete the node](https://github.com/testnet-pride/Node-manuals/blob/main/Testnets/Zetachain/manual.md#delete-the-node)
___
## TestnetPride services 
```http
RPC:      https://zetachain-testnet.testnet-pride.com:443
API:      https://zetachain-testnet-api.testnet-pride.com:443
gRPC:     https://zetachain-testnet-grpc.testnet-pride.com:443
peer:     8aaec5fd35e2c452a0507bad2db1e0ca79d73bb9@zetachain-testnet-peer.testnet-pride.com:26656
```
## Prepare the server
```python
sudo apt update && sudo apt upgrade -y && \
sudo apt install curl tar wget clang pkg-config libssl-dev libleveldb-dev jq build-essential bsdmainutils git make ncdu htop screen unzip bc fail2ban -y
```
```bash
cd $HOME && \
ver="1.20.6" && \
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" && \
sudo rm -rf /usr/local/go && \
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" && \
rm "go$ver.linux-amd64.tar.gz" && \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile && \
source $HOME/.bash_profile && \
go version
```
## Set variables
```bash
MONIKER="<YOUR_NEW_MONIKER>"
WALLET="<YOUR_WALLET_NAME>"
WEBSITE="<YOUR_WEBSITE>"
IDENTITY="<<YOUR_KEYBASE_ID>"
DETAILS='"<YOUR_DESCRIPTION>"'
SECURITY_CONTACT="<YOUR_EMAIL>"
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
## Download the binary
```bash
wget -O $HOME/zetacored https://github.com/zeta-chain/node/releases/download/v6.0.0/zetacored-ubuntu-20-amd64 && \
sudo chmod +x $HOME/zetacored && \
sudo mv $HOME/zetacored /usr/local/bin/zetacored && \
zetacored version
```
## Download configs
```python
mkdir -p $HOME/.zetacored/config/ && \
wget -O $HOME/.zetacored/config/app.toml https://raw.githubusercontent.com/zeta-chain/network-athens3/main/network_files/config/app.toml && \
wget -O $HOME/.zetacored/config/client.toml https://raw.githubusercontent.com/zeta-chain/network-athens3/main/network_files/config/client.toml && \
wget -O $HOME/.zetacored/config/config.toml https://raw.githubusercontent.com/zeta-chain/network-athens3/main/network_files/config/config.toml
```
## Download genesis file
```bash
wget -O $HOME/.zetacored/config/genesis.json https://raw.githubusercontent.com/zeta-chain/network-athens3/main/network_files/config/genesis.json
```
## Create a new wallet and request tokens
```bash
zetacored keys add $WALLET
```
```bash
VALOPER=$(zetacored keys show $WALLET --bech val -a) # ENTER PASSWORD
```
```bash
ADDRESS=$(zetacored keys show $WALLET --address) # ENTER PASSWORD
```
```bash
echo "export VALOPER=$VALOPER" >> $HOME/.bash_profile && \
echo "export ADDRESS=$ADDRESS" >> $HOME/.bash_profile && \
source $HOME/.bash_profile
```
## Disk space optimization # following variables can be customised
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
```bash
sed -i.bak -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.zetacored/config/config.toml && \
sed -i.bak -e "s/^min-retain-blocks *=.*/min-retain-blocks = \"$min_retain_blocks\"/" $HOME/.zetacored/config/app.toml && \
sed -i.bak -e "s/^snapshot-interval *=.*/snapshot-interval = \"$snapshot_interval\"/" $HOME/.zetacored/config/app.toml && \
sed -i.bak -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.zetacored/config/app.toml && \
sed -i.bak -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.zetacored/config/app.toml && \
sed -i.bak -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.zetacored/config/app.toml && \
sed -i.bak -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.zetacored/config/app.toml && \
sed -i.bak -e "s/^min-retain-blocks *=.*/min-retain-blocks = \"$min_retain_blocks\"/" $HOME/.zetacored/config/app.toml && \
sed -i.bak -e "s/^inter-block-cache *=.*/inter-block-cache = \"$inter_block_cache\"/" $HOME/.zetacored/config/app.toml
```
## Add peers
```bash
PEERS="fe8a706ce2538ba81429f89a1bfd28f4e39e9b7d@13.228.103.187:26656,194a2a59bceb4625565c12a2d841d1c0e82f0ee9@65.109.93.58:31656,b0aa015260005cd7947de58a7f8b807638f3edd8@135.181.6.226:28656,25a3adc2370cad7209cb6fccc00a25ae2d2d9a1f@46.21.151.210:26656,87bd556702556b7850b7a42d387232796738eda6@131.153.154.161:26656,3d784cb1141b3888c1f8ddbb21d77de9291089da@65.108.124.57:25656,d55ec9999658d28f6ea65629e578e41c3acb805f@3.233.186.130:26656,af58c82b5f4d2268e0b8ca9150190e438c07d90d@34.239.99.239:26656,733c8bdf0c607341a95d9453cf064b41bc003986@52.203.216.226:26656,a918d08544b5f4e0a9eb20bf91f343eb71b6d5ee@164.90.181.99:26656,202c4bc63b8020b333a306bfbc338b9c27c9890d@161.97.107.122:41656,0844caf1e7be0dc1ce1c0523e87140a3c79a1d77@148.251.177.108:22556,038234610497601373b1d27e27251674c6c81df7@3.218.170.198:26656,8f53a5748f142bd16127b7b7cb1c79772b2ff3c5@131.153.202.63:26656,048c2e9616ddf9b511e58aea87b202552588755a@136.243.9.231:27656,2af8a5ff35b7bddece613f95c2af428ac0f4d062@13.213.91.81:26656,f04cfca9b9fc8e0d5c0083dad20ab9a0fefba505@34.194.62.47:26656,a417c375685afb97b7210d4c101c835521572731@35.170.251.63:26656,2067aaa17c35b80d2af5ddbd96d8aa82e84e8ecd@65.108.66.247:26656,d432b334542ee3943c2258b76bf90dd0180c5d5b@34.194.74.157:26656,845ad4617af8c97942261d6f0b3de78104994ef2@44.212.168.142:26656,730e0a4b91eda7e041f866b6342bb5fa7178d0b0@44.210.204.28:26656,f96cf94d5eabaf554c9294e731b3994b4c532f3a@46.4.5.45:22556,9ca7c129afc0f73e080d0a27dde3165d440ceb75@3.221.179.78:26656,31c9f21b3dff1167993d4291479d8381f59d3dc4@18.213.164.140:26656,2505e8a3b49b7451ed58195c7015c5c677b18365@195.14.6.2:26656,e0bcdfdc274eda6daf7bd4d5b1bedc2e62abb1b7@179.191.144.101:26656,4226fcb3b3809c00bc56283063fc52fa4bfc9a17@18.210.106.52:26656,c1355344beed2224ff1377dd102e6f847cce2cb6@34.253.137.241:26656,d660d4b174edb9e132664e821c0c1652caf3fc07@51.79.77.103:26656,66338a18a755a0c780b011f012ff142ebaa8fa56@44.236.174.26:26656,382f6e3cfafee6d43e5f357002f7ed28f30f1319@198.20.103.46:36610,809c1bdb33c162fdc380372523ccd58131368380@54.77.180.134:26656,55d9651de8e1f15953b9adb5ba4f4816b94fc32d@34.240.40.173:26656,b96c038643c08373535956e3505a5aa955fadb0a@54.254.133.239:26656,0b4893da114055d21e0f598845e80931b07ca153@44.198.196.121:26656,e2551106be2ccd47fa4e963e1899297d8dfa07c8@52.206.155.197:26656,3b148cee21f6a16d53dd7799249afe6f844f7f3c@54.144.102.58:26656,f067e4af69b1faeb03cf7b637b73bbad77ee7038@135.181.216.54:3110,20e1000e88125698264454a884812746c2eb4807@65.108.227.217:22556,1083cf8156c68f2e55338c9fb75658e2ba99e7d8@52.6.81.202:26656,c1bbbfe2a5b15674bf24a869b3e8189b6b410ae7@65.108.231.124:14656,68d47550f977c04e4457300b7f3277718b452b99@65.109.93.35:58656,7581f6a7b3913b900f172633df4e555342b350b1@202.8.10.137:26656,9c26260b0148376d2343c4c8c2e2bd7f3f498cd4@35.162.231.114:26656"
sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.zetacored/config/config.toml
```
## State-sync synchronization
```bash
SNAP_RPC="https://zetachain-testnet.testnet-pride.com:443"
LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 1000)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)
```
```bash
sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"|" $HOME/.zetacored/config/config.toml
```
## Start the node
```bash
echo "[Unit]
Description=Z Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/zetacored start --home $HOME/.zetacored/ --log_format json  --log_level info --moniker $MONIKER
Restart=on-failure
LimitNOFILE=262144

[Install]
WantedBy=multi-user.target" > $HOME/zetacored.service
```
```bash
sudo systemctl daemon-reload && \
sudo systemctl enable zetacored && \
sudo systemctl restart zetacored && \
sudo journalctl -u zetacored -f -o cat
```
## Create a validator
### Check sync status
```bash
curl -s localhost:26657/status | jq .result | jq .sync_info
```
### Check wallet balance
```bash
zetacored q bank balances $ADDRESS
```
### Create a validator
```bash 
zetacored tx staking create-validator \
  --amount=1000000uconst \
  --pubkey=$(zetacored tendermint show-validator) \
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
## USEFUL COMMANDS
### Node status
```python
SERVICE LOGS
```
```bash
journalctl -u zetacored -f -o cat
```
### Service status
```bash
systemctl status zetacored
```
### Check node status
```bash
curl -s localhost:26657/status
```
### Сheck synchronization of your node # if the result is false, the node is synchronized
```bash
curl -s $NODE/status | jq .result.sync_info.catching_up
```
### Check consensus

```bash
curl -s $NODE/consensus_state  | jq '.result.round_state.height_vote_set[0].prevotes_bit_array'
```
### Connected peers
```bash
curl -s $NODE/net_info | jq -r '.result.peers[] | "\(.node_info.id)@\(.remote_ip):\(.node_info.listen_addr | split(":")[2])"' | wc -l
```
### Get validator address 
```bash
echo $VALOPER
```
### Get wallet address
```bash
echo $ADDRESS
```
### JAIL, TOMBSTONED, START_HEIGHT, INDEX_OFFSET
```bash
zetacored q slashing signing-info $(zetacored tendermint show-validator)
```
### Get your peer address
```bash
echo "$(zetacored tendermint show-node-id)@$(curl ifconfig.me):$(curl -s $NODE/status | jq -r '.result.node_info.listen_addr' | cut -d':' -f3)"
```
### Wallet balance
```bash
zetacored q bank balances $ADDRESS
```
### Voting for the proposal
```bash
zetacored tx gov vote <PROPOSAL_ID> <yes|no> --from $WALLET --fees 200uconst -y
```
### check all voted proposals
```bash
zetacored q gov proposals --voter $ADDRESS
```
### Edit validator
```bash
zetacored tx staking edit-validator --website="<YOUR_WEBSITE>" --details="<YOUR_DESCRIPTION>" --moniker="<YOUR_NEW_MONIKER>" --from=$WALLET --fees 200uconst
```
### Ubjail the validator
```bash
zetacored tx slashing unjail --from $WALLET --fees 200uconst
```
### Delegate tokens
```bash
zetacored tx staking delegate $VALOPER <TOKENS_COUNT>uconst--from $WALLET --fees 200uconst -y
```
### Undelegate tokens
```bash
zetacored tx staking unbond $VALOPER <TOKENS_COUNT>uconst --from $WALLET --fees 200uconst -y
```
### Send tokens
```bash
zetacored tx bank send $WALLET <WALLET_TO> <TOKENS_COUNT>uconst --fees 200uconst --gas auto
```
### Change peers and seeds
```bash
peers="<PEERS>"
seeds="<SEEDS>"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/; s/^seeds *=.*/seeds = \"$seeds\"/" $HOME/.zetacored/config/config.toml
```
### Reset private validator file to genesis state and delete addrbook.json
```bash
zetacored tendermint unsafe-reset-all --home $HOME/.zetacored
```
___
### All validators info
```bash
zetacored q staking validators -o json --limit=1000 \
| jq '.validators[] | select(.status=="BOND_STATUS_BONDED")' \
| jq -r '.tokens + " - " + .description.moniker' \
| sort -gr | nl
```
### List all inactive validators 
```bash
zetacored q staking validators -o json --limit=1000 \
| jq '.validators[] | select(.status=="BOND_STATUS_UNBONDED")' \
| jq -r '.tokens + " - " + .description.moniker' \
| sort -gr | nl
```
### Delete the node
```bash
sudo systemctl stop zetacored && \
sudo systemctl disable zetacored; \
sudo rm /etc/systemd/system/zetacored.service; \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .zetacored zetacored; \
sudo rm $(which zetacored)
```

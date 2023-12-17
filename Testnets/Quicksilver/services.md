## Open Endpoints
```http
RPC:      https://rpc-quicksilver-test.trusted-point.com
API:      https://api-quicksilver-test.trusted-point.com
gRPC:     http://grpc-quicksilver-test.trusted-point:9990
gRPC-web: http://grpc-web-quicksilver-test.trusted-point.com:9991
peer:     16ebaa2222c39f37883a075a958aedce8a834de9@peer-quicksilver-test.trusted-point.com:27556
```
## Files
```http
Genesis:  https://raw.githubusercontent.com/trusted-point/Node-manuals/main/Testnets/Quicksilver/genesis.json
Addrbook: https://raw.githubusercontent.com/trusted-point/Node-manuals/main/Testnets/Quicksilver/addrbook.json
Snapshot: https://snapshot-quicksilver-test.trusted-point.com/quicksilver-test.tar.lz4
```

## State-sync synchronization
```python
CHANGE VARIABLES 
```
```bash
RPC=https://rpc-quicksilver-test.trusted-point.com:443
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

sudo systemctl restart quicksilverd
sudo journalctl -u quicksilverd -f -o cat
```

## Snapshot synchronization

```bash
cd $HOME
apt install lz4
sudo systemctl stop quicksilverd
sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1false|" ~/.quicksilverd/config/config.toml
cp $HOME/.quicksilverd/data/priv_validator_state.json $HOME/.quicksilverd/priv_validator_state.json.backup
rm -rf $HOME/.quicksilverd/data
curl -o - -L https://snapshot-quicksilver-test.trusted-point.com/quicksilver-test.tar.lz4 | lz4 -c -d - | tar -x -C $HOME/.quicksilverd --strip-components 2
mv $HOME/.quicksilverd/priv_validator_state.json.backup $HOME/.quicksilverd/data/priv_validator_state.json
wget -O $HOME/.quicksilverd/config/addrbook.json "https://raw.githubusercontent.com/trusted-point/Node-manuals/main/Testnets/Quicksilver/addrbook.json"
sudo systemctl restart quicksilverd && journalctl -u quicksilverd -f -o cat
```bash

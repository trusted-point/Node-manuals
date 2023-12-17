## Open Endpoints
```http
RPC:      http://rpc-quicksilver-test.trusted-point.com
API:      http://api-quicksilver-test.trusted-point.com
gRPC:     http://grpc-quicksilver-test.trusted-point:24090
gRPC-web: http://grpc-web-quicksilver-test.trusted-point.com:24091
peer:     5a3c424c19d9ab694190a7805a2b1a146460d752@peer-quicksilver-test.trusted-point.com:41656
```
## Files
```http
Genesis:  https://raw.githubusercontent.com/trusted-point/Node-manuals/main/Testnets/Quicksilver/genesis.json
Addrbook: https://raw.githubusercontent.com/trusted-point/Node-manuals/main/Testnets/Quicksilver/addrbook.json
Snapshot: http://snapshot-quicksilver-test.trusted-point.com/quicksilver-main.tar.lz4
```

## State-sync synchronization
```python
CHANGE VARIABLES 
```
```bash
RPC=http://rpc-quicksilver-test.trusted-point.com:443
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

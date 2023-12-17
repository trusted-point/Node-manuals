## Open Endpoints
```http
RPC:      https://rpc-quicksilver-main.trusted-point.com
API:      https://api-quicksilver-main.trusted-point.com
gRPC:     http://grpc-quicksilver-main.trusted-point:11190
gRPC-web: http://grpc-web-quicksilver-main.trusted-point.com:11191
peer:     f0e3f421a5e774a12f8ff3380a938659bad7038e@peer-quicksilver-main.trusted-point.com:28756
```
## Files
```http
Genesis:  https://raw.githubusercontent.com/trusted-point/Node-manuals/main/Mainnets/Quicksilver/genesis.json
Addrbook: https://raw.githubusercontent.com/trusted-point/Node-manuals/main/Mainnets/Quicksilver/addrbook.json
Snapshot: https://snapshot-quicksilver-main.trusted-point.com/quicksilver-main.tar.lz4
```

## State-sync synchronization
```python
CHANGE VARIABLES 
```
```bash
RPC=https://rpc-quicksilver-main.trusted-point.com:443
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

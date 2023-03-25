
```
NAME=<TWITTER_HANDLE>
```

```python
CREATE NEW WALLET
```
```
snarkos account new > $NAME.txt && \
PK=$(grep "Private Key" $NAME.txt | awk '{print $3}') && \
VK=$(grep "View Key" $NAME.txt | awk '{print $3}') && \
ADDRESS=$(grep "Address" $NAME.txt | awk '{print $2}') && \
echo "Private Key: $PK" && \
echo "View Key: $VK" && \
echo "Address: $ADDRESS"
```

```python
RECOVER
```
```
PK=<YOUR_PRIVATE_KEY>
VK=<YOUR_VIEW_KEY>
ADDRESS=<YOUR_ADDRESS>
```

```python
TWITT GENERATE
```
```
echo "https://twitter.com/intent/tweet?text=@AleoFaucet%20send%2010%20credits%20to%20$ADDRESS"
# Paste the resulting link into your browser and send a tweet
```

```python
SEARCH
```
```
echo Paste the link:  && read QUOTE_LINK && curl -s $QUOTE_LINK | jq -r '.execution.transitions[0].outputs[0].value'
```


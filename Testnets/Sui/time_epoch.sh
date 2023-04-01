#!/bin/bash

echo Enter the difference between you Time Zone and GMT in hours "(e.g. +5 -5 0)": && read TP
echo -e "\e[32m------------- Calculating time in GMT $TP --------------\e[0m"

# Setting time variable
while true
do
if [[ $TP == -* ]]; then
  TZ1="GMT${TP/-/+}"
else
  if [[ $TP == +* ]]; then
    TZ1="GMT${TP/+/-}"
  else
    TZ1="GMT$TP"
  fi
fi

# Epoch time started + Convert
ML_TIME_START_EPOCH=$(curl -s -X POST -H "Content-Type: application/json" --data '{ "jsonrpc":"2.0", "method":"suix_getLatestSuiSystemState","id":1, "params": [ "0x5"]}' https://rpc-testnet.suiscan.xyz:443 2>/dev/null | jq -r '.result.epochStartTimestampMs')
TIME_START_EPOCH=$(TZ="$TZ1" date --date @$(echo "$ML_TIME_START_EPOCH / 1000" | bc) +"%Y-%m-%d %H:%M:%S")

# Epoch time duration + Convert  
ML_TIME_EPOCH_DURATION=$(curl -s -X POST -H "Content-Type: application/json" --data '{ "jsonrpc":"2.0", "method":"suix_getLatestSuiSystemState","id":1, "params": [ "0x5"]}' https://rpc-testnet.suiscan.xyz:443 2>/dev/null | jq -r '.result.epochDurationMs')
TIME_EPOCH_DURATION=$((ML_TIME_EPOCH_DURATION / 3600000))

# Current time + Convert 
ML_CURRENT_TIME=$(TZ="$TZ1" date +%s%3N)
CURRENT_TIME=$(TZ="$TZ1" date --date @$(echo "$ML_CURRENT_TIME / 1000" | bc) +"%Y-%m-%d %H:%M:%S")

# Current Epoch number  
CURRENT_EPOCH_NUMBER=$(curl --silent https://rpc-testnet.suiscan.xyz/metrics | grep '^current_epoch' | awk '{print $2}')
 
# Time at what Epoch ends + Convert
ML_EPOCH_ENDS_AT=$((ML_TIME_START_EPOCH + ML_TIME_EPOCH_DURATION))
EPOCH_ENDS_AT=$(TZ="$TZ1" date --date @$(echo "$ML_EPOCH_ENDS_AT / 1000" | bc) +"%Y-%m-%d %H:%M:%S")

# Time remeaning till the end + Convert
ML_TIME_TILL_END=$((ML_EPOCH_ENDS_AT - ML_CURRENT_TIME))
TIME_TILL_END=$(date -u -d @$(echo "$ML_TIME_TILL_END /1000" | bc) +"%H hours %M minutes %S seconds")

echo "-------------------------------------------------------"
echo -e "Current Epoch:                      \e[31m\e[1m$CURRENT_EPOCH_NUMBER\e[0m"
echo "-------------------------------------------------------" 
echo "Epoch $CURRENT_EPOCH_NUMBER started at:               $TIME_START_EPOCH"
echo "-------------------------------------------------------"
echo "Your local time:                    $CURRENT_TIME"
echo "-------------------------------------------------------"
echo -e "Epoch \e[31m\e[1m$CURRENT_EPOCH_NUMBER\e[0m ends at:                  \e[32m\e[1m$EPOCH_ENDS_AT\e[0m"
echo "-------------------------------------------------------"
echo -e "Time remaining:          \e[5m\e[33m$TIME_TILL_END\e[0m"
echo
  sleep 5s
done
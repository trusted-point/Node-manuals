import json
import requests
from tabulate import tabulate

with open("wallets.txt", "r") as file:
    wallet_addresses = file.read().splitlines()

url = "https://raw.githubusercontent.com/celestiaorg/networks/master/celestia/pre-genesis.json"
response = requests.get(url)
data = response.json()

balances = []
total_balance = 0

for address in wallet_addresses:
    found = [item for item in data["app_state"]["bank"]["balances"] if item["address"] == address]
    if found:
        balance = found[0]["coins"][0]
        balance_str = int(balance['amount']) // 1000000
    else:
        balance_str = 0

    total_balance += balance_str
    balances.append([address, balance_str])

summary_line = ["Total $TIA", total_balance]
balances.append(summary_line)

headers = ["Address", "Balance in $TIA"]

table = tabulate(balances, headers, tablefmt="grid")
print(table)

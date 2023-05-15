[<img src='https://github.com/Hacker-web-Vi/Hacker-web-Vi/assets/80550154/f669ea63-08d7-42fd-bc0c-fc0e2e4db51d' alt='banner' width= '99.9%'>]()
___
## Analysis of Celestia Bridge node
### **Server specs**
```bash
curl -sL yabs.sh | bash -s
```
* Processor: AMD Ryzen 7 3700X 8-Core Processor
* CPU cores: 16 / 4154.125 MHz
* RAM: 64 GiB
* Swap: 20 GiB
* Disk: 1.8 TiB NVMe Raid 0
* Distro: Ubuntu 20.04.6 LTS
* Kernel: 5.4.0-131-generic
---
### **Disk speed test**

> These measurements provide insights into the disk's performance in terms of data transfer rates and IOPS at different block sizes.

* **Block Size:** The size of the data block used in the speed test.
* **4k and 64k (IOPS):** The input/output operations per second (IOPS) achieved when reading or writing data with the corresponding block size.
* **Read:** The speed at which data can be read from the disk, measured in megabytes per second (MB/s) for the 4k and 64k block sizes.
* **Write:** The speed at which data can be written to the disk, also measured in megabytes per second (MB/s) for the 4k and 64k block sizes.
* **Total:** The total throughput or combined read and write speed of the disk, measured in gigabytes per second (GB/s) for the 4k and 64k block sizes.
```bash
curl -sL yabs.sh | bash -s
```
| **Block Size** | **4k**             **(IOPS)** | **64k            (IOPS)** |
| ---------- | ------------------ | --------------------- |
| Read       | 664.25 MB/s (166.0k) | 1.12 GB/s (17.5k)   |
| Write      | 666.00 MB/s (166.5k) | 1.12 GB/s (17.6k)   |
| Total      | 1.33 GB/s   (332.5k) | 2.25 GB/s (35.1k)   |
|            |                    |                       |
| **Block Size** | **512k**          **(IOPS)** | **1m               (IOPS)** |
| Read       | 1.46 GB/s     (2.8k) | 1.39 GB/s     (1.3k) |
| Write      | 1.54 GB/s     (3.0k) | 1.49 GB/s     (1.4k) |
| Total      | 3.01 GB/s     (5.8k) | 2.88 GB/s     (2.8k) |
---
### **Network speedtest**

> The provided data represents the results of a network speed test, which measures the download and upload speeds of an internet connection.
```bash
sudo apt install speedtest-cli
speedtest-cli
```

|     | Speed         | Value             |
|-----|---------------|-------------------|
|     | **Download**      | 840.78 Mbit/s |
|     | **Upload**        | 802.18 Mbit/s |
---
**Important: Consensus fullnode is running on the same server to which bridge node connected**
### **Prunning type**
```bash
pruning = "nothing"
```
---
### **Network traffic**
* **rx:** This column represents the received data, denoted in gibibytes (GiB), which refers to the amount of data received by the network during that hour.
* **tx:** This column represents the transmitted data, also in gibibytes (GiB), indicating the amount of data sent by the network during that hour.
* **total:** This column shows the total amount of data, in gibibytes (GiB), that was both received and transmitted by the network during the hour.
* **avg. rate:** This column displays the average data transfer rate in megabits per second (Mbit/s) for that specific hour. It indicates the average speed at which data was transferred over the network during that period.
```bash
vnstat -h
```
|     hour  |    rx     |    tx     |   total   |  avg. rate   |
|-----------|-----------|-----------|-----------|--------------|
|   20:00   | 1.50 GiB  | 1.72 GiB  | 3.22 GiB  |  7.69 Mbit/s |
|   21:00   | 2.44 GiB  | 2.84 GiB  | 5.28 GiB  | 12.59 Mbit/s |
|   22:00   | 2.39 GiB  | 2.74 GiB  | 5.12 GiB  | 12.22 Mbit/s |
|   23:00   | 2.41 GiB  | 2.66 GiB  | 5.07 GiB  | 12.11 Mbit/s |
|   00:00   | 2.39 GiB  | 2.74 GiB  | 5.13 GiB  | 12.25 Mbit/s |
|   01:00   | 2.37 GiB  | 2.84 GiB  | 5.22 GiB  | 12.44 Mbit/s |
|   02:00   | 2.36 GiB  | 2.94 GiB  | 5.30 GiB  | 12.65 Mbit/s |
|   03:00   | 2.38 GiB  | 3.03 GiB  | 5.41 GiB  | 12.92 Mbit/s |
|   04:00   | 2.37 GiB  | 2.58 GiB  | 4.95 GiB  | 11.81 Mbit/s |
|   05:00   | 2.35 GiB  | 2.58 GiB  | 4.92 GiB  | 11.75 Mbit/s |
|   06:00   | 2.38 GiB  | 2.68 GiB  | 5.06 GiB  | 12.07 Mbit/s |
|   07:00   | 2.39 GiB  | 2.64 GiB  | 5.03 GiB  | 12.01 Mbit/s |
|   08:00   | 2.40 GiB  | 2.68 GiB  | 5.08 GiB  | 12.11 Mbit/s |
|   09:00   | 2.38 GiB  | 2.60 GiB  | 4.98 GiB  | 11.88 Mbit/s |
|   10:00   | 2.48 GiB  | 3.50 GiB  | 5.98 GiB  | 14.26 Mbit/s |
|   11:00   | 2.35 GiB  | 2.69 GiB  | 5.05 GiB  | 12.04 Mbit/s |
|   12:00   | 2.66 GiB  | 2.87 GiB  | 5.53 GiB  | 13.20 Mbit/s |
|   13:00   | 2.40 GiB  | 2.71 GiB  | 5.11 GiB  | 12.19 Mbit/s |
|   14:00   | 2.35 GiB  | 2.70 GiB  | 5.06 GiB  | 12.07 Mbit/s |
|   15:00   | 2.49 GiB  | 2.96 GiB  | 5.44 GiB  | 12.99 Mbit/s |
|   16:00   | 2.68 GiB  | 3.12 GiB  | 5.80 GiB  | 13.84 Mbit/s |
|   17:00   | 2.58 GiB  | 3.08 GiB  | 5.66 GiB  | 13.51 Mbit/s |
|   18:00   | 1.46 GiB  | 1.17 GiB  | 2.63 GiB  | 15.06 Mbit/s |

### **Disk space usage**
```bash
du -h ~/.celestia-bridge-blockspacerace-0
```
> The output shows the disk usage of the .celestia-bridge-blockspacerace-0 directory.

| **Size** | **Directory/File**                                     |
|------|-----------------------------------------------------|
| 12K  | .celestia-bridge-blockspacerace-0/keys/keyring-test |
| 24K  | .celestia-bridge-blockspacerace-0/keys              |
| 3.2G | .celestia-bridge-blockspacerace-0/index             |
| 4.0K | .celestia-bridge-blockspacerace-0/transients        |
| 15G  | .celestia-bridge-blockspacerace-0/blocks            |
| 15G  | .celestia-bridge-blockspacerace-0/data              |
| **32G**  | **.celestia-bridge-blockspacerace-0**                   |
---
```bash
du -h ~/.celestia-app/data

```
> The output shows the disk usage of the .celestia-app directory.
> 
| Size  | Directory/File                                |
|-------|-----------------------------------------------|
| 36K   | .celestia-app/data/evidence.db                |
| 187M  | .celestia-app/data/snapshots/492000/2         |
| 187M  | .celestia-app/data/snapshots/492000           |
| 187M  | .celestia-app/data/snapshots/493500/2         |
| 187M  | .celestia-app/data/snapshots/493500           |
| 216K  | .celestia-app/data/snapshots/metadata.db      |
| 375M  | .celestia-app/data/snapshots                  |
| 97G   | .celestia-app/data/application.db             |
| 4.2G  | .celestia-app/data/state.db                   |
| 14G   | .celestia-app/data/blockstore.db              |
| 1017M | .celestia-app/data/cs.wal                     |
| 641M  | .celestia-app/data/tx_index.db                |
| 117G  | .celestia-app/data/                           |

### **CPU load**
CPU load was monitored with Grafana + node exporter setup
[<img src='https://github.com/Hacker-web-Vi/Hacker-web-Vi/assets/80550154/5cbad99b-c450-404a-b901-c2f2963bacac' alt='banner' width= '99.9%'>]()
---
### **Memory usage**
RAM was monitored with Grafana + node exporter setup
[<img src='https://github.com/Hacker-web-Vi/Hacker-web-Vi/assets/80550154/820c9d81-79a4-4f82-8f3f-b3e73b6311e7' alt='banner' width= '99.9%'>]()
## About **Celestia**

* **[Celestia](https://celestia.org/)** is a modular consensus and data network, built to enable anyone to easily deploy their own blockchain with minimal overhead.

* Celestia provides consensus and security on-demand, enabling anyone to deploy a blockchain without the overhead of bootstrapping a new consensus network.

* Blockchains built on top of Celestia do not rely on honest majority assumptions for state validity, meaning that they can interoperate with the highest security standards.

* Because Celestia does not validate transactions, its throughput is not bottlenecked by state execution like traditional blockchains. Thanks to a property of data availability sampling, Celestia’s throughput scales with the number of users. 

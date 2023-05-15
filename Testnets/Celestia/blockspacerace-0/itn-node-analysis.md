[<img src='https://github.com/Hacker-web-Vi/Hacker-web-Vi/assets/80550154/f669ea63-08d7-42fd-bc0c-fc0e2e4db51d' alt='banner' width= '99.9%'>]()
___
## About **Celestia**

* **[Celestia](https://celestia.org/)** is a modular consensus and data network, built to enable anyone to easily deploy their own blockchain with minimal overhead.

* Celestia provides consensus and security on-demand, enabling anyone to deploy a blockchain without the overhead of bootstrapping a new consensus network.

* Blockchains built on top of Celestia do not rely on honest majority assumptions for state validity, meaning that they can interoperate with the highest security standards.

* Because Celestia does not validate transactions, its throughput is not bottlenecked by state execution like traditional blockchains. Thanks to a property of data availability sampling, Celestia’s throughput scales with the number of users. 

## Perform analysis of Celestia Bridge node
### **Server specs**
* Processor: AMD Ryzen 7 3700X 8-Core Processor
* CPU cores: 16 / 4154.125 MHz
* RAM: 64 GiB
* Swap: 20 GiB
* Disk: 1.8 TiB NVMe Raid 0
* Distro: Ubuntu 20.04.6 LTS
* Kernel: 5.4.0-131-generic

### **Disk speed test**
| **Block Size** | **4k**             **(IOPS)** | **64k            (IOPS)** |
| ---------- | ------------------ | ------------------- |
| Read       | 664.25 MB/s (166.0k) | 1.12 GB/s (17.5k)   |
| Write      | 666.00 MB/s (166.5k) | 1.12 GB/s (17.6k)   |
| Total      | 1.33 GB/s   (332.5k) | 2.25 GB/s (35.1k)   |
|            |                    |                     |
| **Block Size** | **512k**          **(IOPS)** | **1m            (IOPS)** |
| ---------- | ------------------ | ------------------- |
| Read       | 1.46 GB/s     (2.8k) | 1.39 GB/s     (1.3k) |
| Write      | 1.54 GB/s     (3.0k) | 1.49 GB/s     (1.4k) |
| Total      | 3.01 GB/s     (5.8k) | 2.88 GB/s     (2.8k) |

### **Network speedtest**
|     | Speed         | Value        |
|-----|---------------|--------------|
|     | Download      | 840.78 Mbit/s |
|     | Upload        | 802.18 Mbit/s |

### Prunning type
pruning = "nothing"
indexer = "null"

### Network traffic
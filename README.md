#Notable Info
Create a CaseSensitive Volume and clone this repo in that volume then run the script bootstrap.sh

Per vedere i processi che ascoltano su una determinata porta
```shell
netstat -vanp tcp | grep <port_number>
```
```shell
lsof  -itcp:<port_number>
```

Processo attivo

```shell
ps <PID>
```

Read defaults in macos

```shell
default read >> ~/defaults.txt
```

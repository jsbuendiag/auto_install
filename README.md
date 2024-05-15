### Description
Very simple bash script used to install some main tools for bug bounty. This should be used oin an Ubuntu VPS or virutal machine. This was originally tested on Ubuntu Server 22.04 LTS. On other distros or versions probably will not work or some tools will fail to install.

I am not an expert in bash, so many things might go wrong and may have a better way to do it. Hope you find this useful!

### Donwload

Donwload the script directly. Remember to go first to your working folder:

```
wget https://raw.githubusercontent.com/jsbuendiag/auto_install/main/auto_install.sh
```

### Usage
First give the appropiate privileges to the file:
```
chmod +x auto_install.sh
```

Then just execute the program:
```
sudo -u <your sudoer user> -E ./auto_install.sh
```
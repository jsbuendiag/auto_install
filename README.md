### Description
Very simple bash script used to install some main tools for bug bounty. This should be used oin an Ubuntu VPS or virutal machine. This was originally testes on Ubuntu Server 24.04 LTS.

I am not an expert in bash, so many things might go wrong and may have a better way to do it.

### Usage
First give the appropiate privileges to the file:

`chmod +x auto_install.sh`

Then just execute the program:

`sudo -u <your sudoer user> -E ./auto_install.sh`
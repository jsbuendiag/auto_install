#!/bin/bash


tools_to_install=('ruby' 'gem' 'pip3' 'prips' 'libpcap-dev' 'nmap' 'go' 'amass' 'massdns' 'pdtm' 'metabigor' 'gospider' 'SubDomainizer' 'getJS' 'GoLinkFinder' 'github-subdomains' 'shosubgo' 'gotator' 'DNScewl' 'altdns' 'brutespray' 'github-endpoints' 'cloudflare-origin-ip' 'gowitness' 'subzy' 'ffuf' 'waymore' 'gau' 'unfurl' 'anew' 'wpscan' 'sqlmap')

confirm () {
    while true; do
        read -p "$1 (Y/n): " answer
        case $answer in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
            *) echo "Invalid input. Please enter Y or N." ;;
        esac
    done
}

# # Export and source the following on your terminal before running the script:
# echo "Export and source the following on your terminal before running the script:"
# echo 'echo "export PATH=$PATH:/usr/local/go/bin:$HOME/.local/bin:$HOME/go/bin:$HOME/.pdtm/go/bin" | sudo tee -a /etc/profile
# echo "export PATH=$PATH:/usr/local/go/bin:$HOME/.local/bin:$HOME/go/bin:$HOME/.pdtm/go/bin" | tee -a $HOME/.profile
# # Metabigor variable
# echo "export ASSUME_NO_MOVING_GC_UNSAFE_RISK_IT_WITH=go1.20" | tee -a $HOME/.profile
# cd $HOME
# source .profile'


# Check the return value and exit if it's 1 (indicating "no")
echo "Execute command as 'sudo -u <your sudoer user> -E ./<name of script>'"
if confirm "Do you want to continue, assuming that you executed the command as specified?"; then
  echo "Continuing the program."
else
    echo "Exiting the program"
    exit 1
fi

echo "export PATH=$PATH:/usr/local/go/bin:$HOME/.local/bin:$HOME/go/bin:$HOME/.pdtm/go/bin" | sudo tee -a /etc/profile
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/.local/bin:$HOME/go/bin:$HOME/.pdtm/go/bin" | tee -a $HOME/.profile
# Metabigor variable
echo "export ASSUME_NO_MOVING_GC_UNSAFE_RISK_IT_WITH=go1.20" | tee -a $HOME/.profile
cd $HOME
source /etc/profile
source .profile

echo "Updating and upgrading."
sudo apt-get -y update
sudo apt-get -y upgrade
echo "Done!"

# sudo rm /usr/lib/python3.$(python3 -V | cut -d ' ' -f2 | cut -d '.' -f2)/EXTERNALLY-MANAGED
echo "Installing gcc"
sudo apt -y install gcc

echo "Installing ruby"
sudo apt -y install ruby
echo "Done!"

echo "Installing gem"
sudo apt -y install gem
echo "Done!"

echo "Installing pip3"
sudo apt -y install python3-pip
echo "Done!"

echo "Installing pipx"
sudo apt -y install pipx
echo "Done!"

echo "Installing prips"
sudo apt -y install prips
echo "Done!"

echo "Installing libpcap-dev"
sudo apt install -y libpcap-dev

echo "Installing nmap"
sudo apt-get -y install nmap
echo "Done!"

# Installing wpscan
echo "Installing wpscan"
sudo apt install curl git libcurl4-openssl-dev make zlib1g-dev gawk g++ gcc libreadline6-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config ruby ruby-bundler ruby-dev -y
sudo gem install wpscan
wpscan --update
echo "Done!"

# Installing sqlmap
echo "Installing sqlmap"
sudo apt install sqlmap
echo "Done!"

# Installing massdns
cd $HOME
mkdir tools
git clone https://github.com/blechschmidt/massdns.git "$HOME/tools/massdns"
cd $HOME/tools/massdns/
make
sudo cp $HOME/tools/massdns/bin/massdns /usr/bin/
echo "Done!"

# Installing sudomainzer
echo "Installing subdomainzer"
cd $HOME/tools
git clone https://github.com/nsonaniya2010/SubDomainizer.git
cd SubDomainizer
pip3 install -r requirements.txt 
sudo cp SubDomainizer.py /usr/bin/
echo "Done!"

# Installing DNSCewl   
echo "Installing DNSCewl"
cd $HOME/tools
git clone https://github.com/codingo/DNSCewl.git
cd DNSCewl
make
sudo cp DNScewl /usr/bin
echo "Done!"

# Installing altdns
pipx install py-altdns==1.0.2
echo "Done!"


# Installing cloudflare origin ip
echo "Installing cloudflare origin ip"
cd $HOME/tools
git clone https://github.com/gwen001/cloudflare-origin-ip
cd cloudflare-origin-ip
pip3 install -r requirements.txt
sudo cp cloudflare-origin-ip.py /usr/bin
echo "Done!"

# Installig waymore
echo "Installing waymore"
pipx install waymore
echo "Done!"

install_go () {
    wget https://go.dev/dl/go1.22.3.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.3.linux-amd64.tar.gz
    rm go1.22.3.linux-amd64.tar.gz
    echo "Go installed $(go version)."
}


# Verify that go is installed
if command -v go >/dev/null; then
    echo "go is already installed with version $(go version)."
    if confirm "Do you want to remove and install the latest version?"; then
        echo "Latest version of go will be installed."
        install_go

    else
        echo "Keeping the actual version of go $(go version)."
    fi
else
    echo "go is not installed. Go will be installed."
    install_go
fi

# Installing amass
echo "Installing amass."
go install -v github.com/owasp-amass/amass/v4/...@master
echo "Done!"

# Intalling all tools from project discovery
echo "Installing the package manager from project discovery"
go install -v github.com/projectdiscovery/pdtm/cmd/pdtm@latest
echo "Installing all Project Discovery tools"
pdtm -ia
nuclei
echo "Done!"

# Installing brutespray
echo "Installing brutespray"
cd $HOME/tools
git clone https://github.com/x90skysn3k/brutespray.git
cd brutespray
go build -o brutespray main.go
mv $HOME/tools/brutespray/brutespray/main $HOME/tools/brutespray/brutespray/brutespray
sudo cp $HOME/tools/brutespray/brutespray/brutespray $HOME/go/bin/brutespray
echo "Done!"

# Installing metabigor
git clone https://github.com/j3ssie/metabigor.git "$HOME/tools/metabigor"
cd $HOME/tools/metabigor
go install
echo "Done!"

# Installing hakrevdns, hakrawler and hakip2host
echo "Installing hakrevdns, hakrawler, and hakip2host"
go install github.com/hakluke/hakrevdns@latest
go install github.com/hakluke/hakrawler@latest
go install github.com/hakluke/hakip2host@latest
echo "Done!"

# Installing gospider
echo "Installing gospider"
GO111MODULE=on go install github.com/jaeles-project/gospider@latest
echo "Done!"

# Installing getJS
echo "Installing getJS"
go install github.com/003random/getJS@latest
echo "Done!"

#Installing golinkfinder
echo "Installing golinkfinder"
go install github.com/0xsha/GoLinkFinder@latest
echo "Done!"

# Installing github subdomain
echo "Installing github-subdomain"
go install github.com/gwen001/github-subdomains@latest
echo "Done!"

# Installig shosubgo
echo "Installing shosubgo"
go install github.com/incogbyte/shosubgo@latest
echo "Done!"

# Installing gotator
echo "Installing gotator"
go install github.com/Josue87/gotator@latest
echo "Done!"

# Installing github-endpoints
echo "Installing github endpoints"
go install github.com/gwen001/github-endpoints@latest
echo "Done!"

# Installing gowitness
echo "Installing gowitness"
go install github.com/sensepost/gowitness@latest
echo "Done!"

# Installing subzy
echo "Installing subzy"
go install -v github.com/LukaSikic/subzy@latest
echo "Done!"

# Installing ffuf
echo "Installing ffuf"
go install github.com/ffuf/ffuf/v2@latest
echo "Done!"

# Installing cloudrecon
echo "Installing CloudRecon"
go install github.com/g0ldencybersec/CloudRecon@latest
echo "Done!"

# Installing gau
echo "Installing gau"
go install github.com/lc/gau/v2/cmd/gau@latest
echo "Done!"

# Installing unfurl
echo "Installing unfurl"
go install github.com/tomnomnom/unfurl@latest
echo "Done!"

# Installing anew
echo "Installing anew"
go install -v github.com/tomnomnom/anew@latest
echo "Done!"

# Installing wordlists

# Downloading assetnote wordlist
echo "Downloading assetnote wordlist"
cd $HOME/tools
mkdir assetnote
cd assetnote
wget -r --no-parent -R "index.html*" https://wordlists-cdn.assetnote.io/data/ -nH -e robots=off
echo "Done!"

# Downloading seclists
echo "Downloading seclist"
cd $HOME/tools
wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O SecList.zip \
  && unzip SecList.zip \
  && rm -f SecList.zip
echo "Done!"

# Downloading jhaddix all dns
echo "Downloading jhaddix all dns list"
cd $HOME/tools
wget https://gist.githubusercontent.com/jhaddix/86a06c5dc309d08580a018c66354a056/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt
echo "Done!"

echo "Installation completed of all software!!!!!!"
echo "*************************************************************"
echo "TOOLS INSTALLED:"

for tool in "${tools_to_install[@]}"; do
    echo "$tool"
    command -v "$tool"
    if command -v "$tool" >/dev/null 2>&1; then   
        echo "[X] $tool installed"
    else
        echo "[] $tool NOT INSTALLED"
    fi
done

echo "*************************************************************"

echo "Check your $HOME/tools folder for non-go tools"
echo "Check your $HOME/go/bin folder for go tools"
echo "Remember to set sources file for subfinder and amass"
echo "Remember to set token for good scans in wpscan"
echo "Remember you can get a 2 weeks old database if you are unable to launch a VPS for CloudREcon in: https://kaeferjaeger.gay/?dir=sni-ip-ranges"
echo "Set environment variables for cloud-origin-ip of Censys: CENSYS_UID and CENSYS_SECRET and SecurityTrails: SECURITY_TRAILS_API_KEY"
echo "Github tools will ask you for your token"
echo "Get to hack!!!"


## to install karma v2
# git clone https://github.com/Dheerajmadhukar/karma_v2.git
# python3 -m pip install shodan mmh3
# apt install jq -y
# go install github.com/tomnomnom/httprobe@latest
# git clone https://github.com/codingo/Interlace.git
# python3 setup.py install --user
# sudo apt -y install lolcat
# go install -v github.com/tomnomnom/anew@latest

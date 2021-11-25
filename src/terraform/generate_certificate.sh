#!/bin/bash

# copy the cert over from windows when running in WSL and if the cert exist
if grep -q WSL /proc/version; then
    windowsLOCALAPPDATA="`wslvar LOCALAPPDATA`"
    linuxPath="`wslpath $windowsLOCALAPPDATA`"
    [[ -f "$linuxPath/mkcert/rootCA.pem" ]] && echo "Copying $linuxPath/mkcert/rootCA.pem to WSL location" && cp $linuxPath/mkcert/rootCA.pem ~/.local/share/mkcert/rootCA.pem
    [[ -f "$linuxPath/mkcert/rootCA-key.pem" ]] && echo "Copying $linuxPath/mkcert/rootCA-key.pem to WSL location" && cp $linuxPath/mkcert/rootCA-key.pem ~/.local/share/mkcert/rootCA-key.pem
fi
mkdir -p ../../src/certs
mkcert -install
echo "Copying ~/.local/share/mkcert/rootCA.pem to ../../src/certs" && cp ~/.local/share/mkcert/rootCA.pem ../../src/certs/cacerts.crt
echo "Copying ~/.local/share/mkcert/rootCA-key.pem to ../../src/certs" && cp ~/.local/share/mkcert/rootCA-key.pem ../../src/certs/cacerts.key
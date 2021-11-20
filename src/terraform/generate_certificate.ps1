New-Item -ItemType Directory -Force -Path ../../src/certs
mkcert -install
Copy-Item $env:LOCALAPPDATA/mkcert/rootCA.pem ../../src/certs/cacerts.crt
Copy-Item $env:LOCALAPPDATA/mkcert/rootCA-key.pem ../../src/certs/cacerts.key
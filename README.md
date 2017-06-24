# Tor client as Alpine Docker image

This is tiny docker container for TOR client.

It expose two ports:
 - **9150** as SOCKS-proxy for client connections.  
 - **9051** as Tor Control port.
Default password for Control Port "**1234567890**".
You can change it via PASSWORD environment variable.

# Usage

Basic ```docker run``` command:
```sh
docker run -p 9150:9150 -p 9051:9051 -e PASSWORD=myPassword --name tor tarhan/tor-alpine:latest
```

Or you can use ```docker-compose.yml```:
```yaml
version: "2.1"
services:
  tor:
    image: "tarhan/tor-alpine:latest"
    environment:
      PASSWORD: myPassword
    ports:
      - "9150:9150"
      - "9051:9051"
```

# Checking exit node ip address
You can check resulting ip using following command:  
```sh
curl --socks5-hostname localhost:9150 http://ipv4bot.whatismyipaddress.com
```

# Specify exit nodes
You can specify exist nodes by defining ```EXIT_NODES``` environment variable in format used by torrc: ```{us},{hk}```.  
If you need only single country you can define ```COUNTRY``` environment variable in form of 2-letter country code.  

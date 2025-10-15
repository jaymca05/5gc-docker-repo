# Open5GS v2.7.6 SA — Dockerized

This repository contains Dockerfiles, configuration, and a \`docker-compose.yml\` setup for running **Open5GS v2.7.6** in **5G Standalone (SA)** mode.

## Structure

- \`base/\` — common build base (build Open5GS and share artifacts)  
- One directory per NF (NRF, AMF, SMF, UPF, UDM, UDR, AUSF, PCF)  
- Each NF directory has a \`Dockerfile\` and its \`config.yaml\`  
- \`docker-compose.yml\` — orchestration file  
- \`README.md\` — this file  

## Usage

1. Run \`docker-compose up --build\` after adjusting configs.  
2. Monitor NF logs: \`docker-compose logs -f <nfname>\`  
3. Adapt config files (e.g. PLMN, interface IPs, slices, routing).  

## Tips & Caveats

- You may need “wait-for” logic so NFs only start once dependencies are ready.  
- For UPF, forwarding to external networks may require extra capabilities (e.g. \`--cap-add=NET_ADMIN\`) or host network settings.  
- Ensure Docker/host enables IP forwarding (e.g. \`sysctl net.ipv4.ip_forward=1\`).  
- Logs go to stdout / stderr — use \`docker logs\` or \`docker-compose logs\`.
# 5gc-docker-repo

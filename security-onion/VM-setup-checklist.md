# Security Onion VM Setup Checklist

Security Onion is best deployed as its own VM or appliance, not squeezed into the same Docker compose stack as Wazuh and ELK Lite.

## VM Sizing

For a private lab:

| Mode | CPU | RAM | Disk | NICs | Use |
| --- | ---: | ---: | ---: | ---: | --- |
| Import | 2 | 4 GB | 100 GB | 1 | Offline PCAP/EVTX import |
| Evaluation | 4 | 8 GB | 200 GB | 2 | Short temporary tests |
| Standalone | 4 | 24 GB | 200 GB | 2 | Long-running small SOC lab |

Use 32 GB RAM and SSD-backed storage if you can. Security Onion's own docs treat the listed values as bare minimums.

## Network

1. NIC 1: management network with a static IP.
2. NIC 2: sniffing network with no IP address.
3. Put lab endpoints on a virtual switch that can be mirrored to the sniffing NIC, or place the Security Onion sniffing NIC on the same internal segment for exercises.
4. Keep the management UI reachable only from your analyst workstation.

## Install

1. Download and verify the official ISO from https://securityonion.net/download/.
2. Boot the ISO in the VM.
3. Complete the OS installer.
4. After reboot, run Setup if it does not auto-start:

   ```bash
   sudo SecurityOnion/setup/so-setup iso
   ```

5. Choose Standalone for a persistent private lab if resources allow.
6. Confirm SOC Console, Alerts, Hunt, Cases, and Kibana load.

## Endpoint Visibility

Security Onion 3 uses Elastic Agent for host visibility. Deploy endpoint agents from the Security Onion Console Downloads page only after your deployment supports agent intake. Standalone and Distributed deployments are appropriate. Import and Evaluation modes are intentionally limited.

## Optional Forwarding To ELK Lite

Use the template in [custom-logstash-forwarding](custom-logstash-forwarding/README.md) to forward selected events to the lab ELK listener on port `5514`.

Do not forward everything by default. Start with one dataset such as Zeek DNS or Suricata alerts, confirm volume, then expand.


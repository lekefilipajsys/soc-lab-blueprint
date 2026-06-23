# SOC Lab Architecture

This design assumes private virtualization only: VirtualBox, VMware, Proxmox, Hyper-V, or an equivalent isolated lab platform.

## Network Zones

| Zone | Example CIDR | Purpose | Internet |
| --- | --- | --- | --- |
| Management | `10.10.10.0/24` | Dashboards, SSH/RDP, agent enrollment | Optional NAT for updates only |
| Sensor / Mirror | No IP on sniffing NIC | Security Onion traffic capture | No |
| Endpoint Lab | `10.20.20.0/24` | Windows/Linux test machines | Optional NAT |
| Tooling | `10.30.30.0/24` | ELK Lite and Wazuh if separate from endpoints | Optional NAT |

Use static IPs for Wazuh, Security Onion management, and ELK Lite. Keep collection ports reachable only from the lab subnets.

## Component Roles

### Security Onion

Use Security Onion for network-oriented SOC work:

- Suricata and Zeek visibility.
- Packet capture and metadata hunting.
- Security Onion Console alerts, cases, detections, Hunt, Kibana, and dashboards.
- Endpoint Elastic Agent intake when Security Onion is deployed in Standalone or Distributed mode.

Do not rely on Evaluation mode for a long-running SOC lab. It is good for quick tests, but it does not support adding Elastic agents or additional nodes.

### Wazuh

Use Wazuh for host-oriented SOC work:

- Agent-based host log collection.
- File integrity monitoring.
- Security configuration assessment.
- Vulnerability and inventory visibility.
- Active response after rules are tuned and tested.

Start with passive alerting. Move to blocking only after you know exactly which rule IDs and source fields are firing.

### ELK Lite

Use ELK Lite as an independent practice stack:

- Learn Elasticsearch, Kibana, and Logstash without changing Security Onion internals.
- Receive selected forwarded events from Security Onion or any syslog/JSON source.
- Build lab dashboards and practice queries against `soc-lab-*`.

The included compose file disables Elastic authentication and binds Elasticsearch/Kibana to localhost. This is deliberate for a private lab, not for production.

## Data Flows

| Source | Destination | Protocol | Purpose |
| --- | --- | --- | --- |
| Wazuh agents | Wazuh manager | `1514/tcp` | Host telemetry and alerts |
| Wazuh agent enrollment | Wazuh manager | `1515/tcp` | Agent registration |
| Security Onion sniffing NIC | Internal lab switch/SPAN | Passive | Network metadata and IDS alerts |
| Security Onion Logstash | ELK Lite Logstash | `5514/tcp` or `5514/udp` | Optional selected JSON event forwarding |
| Generic syslog devices | ELK Lite Logstash | `5515/tcp` or `5515/udp` | Simple syslog intake |
| Analyst browser | Wazuh | `443/tcp` | Wazuh dashboard |
| Analyst browser | Security Onion | `443/tcp` | SOC Console and Kibana |
| Analyst browser | ELK Lite | `5601/tcp` localhost | Kibana practice stack |

## Detection Coverage

| Detection Goal | Best Tool | Notes |
| --- | --- | --- |
| Endpoint authentication failures | Wazuh | Tune per OS and service. |
| Unauthorized file/config changes | Wazuh | Use FIM for sensitive directories and registry keys. |
| Suspicious PowerShell or script activity | Wazuh + Windows event logs | Use Sysmon on Windows endpoints if available. |
| Network scans or service discovery | Security Onion | Suricata/Zeek usually surface this faster than host logs. |
| DNS anomalies | Security Onion | Forward selected Zeek DNS events to ELK Lite if desired. |
| Generic log search practice | ELK Lite | Use synthetic data or forwarded lab-only events. |

## Response Model

1. Alert arrives in Wazuh or Security Onion.
2. Analyst validates source, destination, user, host, time, and event history.
3. Analyst opens a Security Onion case or records a Wazuh note.
4. Containment is manual first: isolate VM network adapter, disable account, stop service, or block a source IP.
5. Wazuh active response may be enabled later for narrow, proven rules.
6. Recovery includes patching, credential reset, service restoration, and a detection note.


# SOC Lab Operations

## Daily Startup

1. Start the virtualization platform.
2. Start Security Onion first and wait for `so-status` to show healthy services.
3. Start Wazuh and confirm agents are active in the dashboard.
4. Start ELK Lite if you are forwarding events or practicing Kibana.
5. Confirm time sync across all VMs. Time drift makes investigations painful.

## Health Checks

### Wazuh

```powershell
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
docker logs wazuh.manager --tail 100
docker logs wazuh.dashboard --tail 100
```

Confirm:

- Agents appear as active.
- New alerts are being indexed.
- Dashboard login works.
- No disk volume is nearly full.

### ELK Lite

```powershell
docker compose ps
Invoke-RestMethod http://localhost:9200/_cluster/health
```

Confirm:

- Elasticsearch health is green or yellow for a single-node lab.
- Logstash is listening on `5514` and `5515`.
- Kibana loads and the `soc-lab-*` data view has recent events.

### Security Onion

Run from the Security Onion VM:

```bash
sudo so-status
sudo so-test
```

Confirm:

- The management interface is reachable from the analyst workstation.
- The sniffing interface has no IP address.
- Alerts, Hunt, and Kibana load from SOC Console.

## Retention

For a private lab, start small:

- ELK Lite: 7-14 days of `soc-lab-*` indices.
- Wazuh: 14-30 days if disk allows.
- Security Onion: keep hot indices to the shortest period that still supports your exercises.

Packet capture grows quickly. Keep PCAP retention intentionally short unless you have dedicated storage.

## Updates

Update one layer at a time:

1. Snapshot or back up the VM/container data.
2. Update Security Onion using its supported update process.
3. Update Wazuh using the matching official Docker tag and migration notes.
4. Update Elastic stack version in `elk-lite\.env`.
5. Re-run test events and a known Wazuh alert to confirm detection still works.

## Backups

Back up:

- Wazuh custom rules, agent groups, and compose/runtime directory.
- Security Onion cases and custom detections.
- ELK Lite dashboards, index templates, and compose files.
- VM snapshots before major changes.

Do not rely only on snapshots for long-lived evidence. Export key alerts, case notes, and timelines into a separate evidence folder.

## Isolation Rules

- Dashboards must stay on host-only/private networks.
- Do not bridge lab malware-analysis hosts to your home/office LAN.
- Use NAT only when needed for updates, then disable it again.
- Keep default credentials only for first boot, then change them.
- Document every forwarding rule and firewall opening.


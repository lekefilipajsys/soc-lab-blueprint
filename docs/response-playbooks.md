# Response Playbooks

These playbooks are for private lab practice. Start every response manually. Enable automated blocking only after you have tested the rule, source fields, and rollback path.

## Universal Triage

1. Record alert source, rule name, rule ID, host, user, source IP, destination IP, process, and timestamp.
2. Check whether the alert is a first occurrence or part of a pattern.
3. Pivot in the right system:
   - Wazuh: host timeline, agent events, FIM, inventory, vulnerabilities.
   - Security Onion: Alerts, Hunt, Zeek, Suricata, DNS, HTTP, PCAP.
   - ELK Lite: forwarded JSON/syslog in `soc-lab-*`.
4. Decide severity: informational, suspicious, confirmed incident, or false positive.
5. Contain only if the activity is confirmed or clearly unsafe.

## SSH Brute Force Against a Lab Host

Detection:

- Wazuh authentication failure rules on the endpoint.
- Security Onion alerts or Zeek connection patterns if traffic crosses the sensor.

Triage:

- Count failures by source IP, username, and time window.
- Check whether any login succeeded after the failures.
- Confirm the destination host and service are expected to be reachable.

Containment:

- Manually block the source IP on the target VM or lab firewall.
- If repeatable and low-noise, enable the Wazuh `firewall-drop` active response for the exact rule ID and a short timeout.

Recovery:

- Rotate any account password that had a successful login.
- Disable unnecessary SSH exposure inside the lab.
- Add the event to a Security Onion case if network evidence exists.

## Suspicious PowerShell On Windows Endpoint

Detection:

- Wazuh Windows event collection.
- Sysmon events if installed.
- Custom Wazuh rule matching risky command-line indicators.

Triage:

- Identify parent process, user, host, command line, and script path.
- Check whether the command came from an admin tool, software installer, or an unexpected source.
- Search Security Onion for outbound network traffic from the host at the same time.

Containment:

- Disconnect the VM network adapter if activity is confirmed.
- Disable the affected account in the lab directory or local users.
- Preserve logs before reverting a snapshot.

Recovery:

- Remove persistence, restore clean snapshot if this is a malware-analysis exercise, and document the detection gap.

## Unauthorized Sensitive File Change

Detection:

- Wazuh FIM on selected directories such as `/etc`, `/var/www`, application configs, or Windows registry paths.

Triage:

- Identify changed file, hash before/after, user, process, and host.
- Determine whether the change matches an approved lab activity.

Containment:

- Stop the affected service if the file controls authentication, network exposure, or execution.
- Revert the file from a known-good copy.

Recovery:

- Add a higher-severity custom rule for repeat sensitive paths.
- Document expected maintenance windows to reduce false positives.

## Network Scan or Discovery Activity

Detection:

- Security Onion Suricata alerts.
- Zeek connection volume, service enumeration, or DNS activity.

Triage:

- Identify scanner IP, target range, ports, and duration.
- Check whether the source is an approved vulnerability scanner VM.
- Pivot from the source IP into host logs in Wazuh.

Containment:

- Move the scanner VM to an isolated segment or disable its network adapter.
- If the source is external to the lab, block at the lab firewall.

Recovery:

- Create a case timeline from Security Onion alerts and Zeek logs.
- Add allowed scanner IPs to documentation, not broad suppression rules.

## Automated Response Readiness Checklist

Before enabling a Wazuh active response:

- The rule ID is stable and specific.
- The rule fires only for events that justify containment.
- The source field used by the response is always present and correct.
- The timeout is short enough for mistakes to be recoverable.
- You have tested rollback.
- The lab has no production network path.


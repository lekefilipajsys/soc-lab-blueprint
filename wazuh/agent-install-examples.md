# Wazuh Agent Enrollment Notes

Use the Wazuh dashboard whenever possible:

1. Open `https://localhost`.
2. Go to Agent management.
3. Select the endpoint OS.
4. Set the Wazuh manager address to the private lab IP of the Docker host or Wazuh VM.
5. Run the generated command on the endpoint.

## Required Ports

| Port | Purpose |
| --- | --- |
| `1514/tcp` | Agent event transport |
| `1515/tcp` | Agent enrollment |
| `443/tcp` | Dashboard |
| `55000/tcp` | Wazuh API |

Keep these restricted to private lab subnets.

## Windows Endpoint Checklist

- Install the Wazuh agent as Administrator.
- Ensure the Windows endpoint can resolve or reach the Wazuh manager IP.
- Consider installing Sysmon for richer process and network telemetry.
- Confirm the agent appears as active in the Wazuh dashboard.

## Linux Endpoint Checklist

- Install the agent using the dashboard-generated command.
- Confirm `/var/ossec/bin/wazuh-control status`.
- Add FIM paths selectively. Avoid monitoring the entire filesystem in a small lab.

## Containerized Agent

The Wazuh Docker documentation includes a containerized Wazuh agent option. It is useful for collecting logs from a syslog/logging container, but it cannot fully inspect the Docker host unless you deliberately mount host paths and accept the security tradeoffs.


# GitHub Publish Checklist

Use this before making the repository public.

## Repository Setup

- Repository name: `private-soc-lab-blueprint` or `isolated-soc-lab`.
- Description: `Private SOC lab blueprint using Security Onion, Wazuh, and ELK for monitoring, detection, and response practice.`
- Suggested topics: `soc`, `blue-team`, `security-onion`, `wazuh`, `elk`, `elasticsearch`, `kibana`, `logstash`, `homelab`, `cybersecurity`.
- License: MIT.

## Safety Review

- No `.env` files are committed.
- No generated Wazuh certificates are committed.
- No packet captures, endpoint logs, EVTX files, screenshots with private IPs, or VM exports are committed.
- No real API keys, usernames, passwords, hostnames, or internal IP plans are committed.
- All dashboards and ports are described as private-lab only.

## Functional Review

Run from the repository root:

```powershell
.\scripts\validate-repo.ps1
```

If Docker is installed, also run:

```powershell
docker compose -f elk-lite\docker-compose.yml config
```

Then test the lab on a disposable machine:

```powershell
cd elk-lite
Copy-Item .env.example .env
docker compose up -d
.\scripts\send-test-events.ps1
docker compose down
```

## README Review

- Quick Start works from a cloned repository path.
- The architecture diagram renders on GitHub.
- Default credentials are called out as temporary.
- Security Onion is described as a VM/appliance, not a compose container.
- Response automation warnings are clear.

## Optional Polish

- Add screenshots with synthetic data only.
- Add a short demo GIF of Kibana receiving validation events.
- Add a release tag after the first tested deployment, for example `v0.1.0`.


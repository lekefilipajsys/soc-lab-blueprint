# Contributing

Thanks for improving this private SOC lab blueprint.

## Scope

Good contributions include:

- Safer deployment defaults.
- Better detection engineering examples.
- Clearer Security Onion, Wazuh, or ELK setup notes.
- Lab-only response playbooks.
- Documentation fixes and compatibility notes.

Please keep this project focused on lawful, defensive, isolated lab use.

## Ground Rules

- Do not commit credentials, API keys, certificates, packet captures, endpoint logs, VM exports, or real incident data.
- Do not add offensive automation, exploit code, weaponized payloads, or instructions for unauthorized systems.
- Prefer synthetic validation events and benign test cases.
- Keep examples vendor-neutral when possible and document tool versions when they matter.

## Pull Request Checklist

- The change is useful for an isolated private lab.
- No secrets or generated runtime files are included.
- Markdown links still resolve.
- XML examples parse.
- `docker compose -f elk-lite/docker-compose.yml config` succeeds on a machine with Docker.
- Any response automation is opt-in and clearly warned.


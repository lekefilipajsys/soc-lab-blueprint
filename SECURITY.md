# Security Policy

This project is for defensive security learning in private, isolated virtual environments.

## Supported Use

Supported:

- SOC analyst practice.
- Blue-team monitoring and detection labs.
- Synthetic event generation.
- Host and network telemetry exercises in systems you own or have permission to test.

Not supported:

- Public Internet exposure of dashboards or collection ports.
- Unauthorized monitoring or testing.
- Offensive automation or exploit delivery.
- Use as production security architecture without review by qualified staff.

## Reporting Issues

If you find a dangerous default, leaked secret, unsafe instruction, or misleading response guidance, open a GitHub issue with:

- A short description.
- The affected file and line.
- Why it creates risk.
- A safer recommendation if you have one.

Do not include real logs, credentials, packet captures, or sensitive environment details in public issues.

## Lab Safety Defaults

- Use host-only or internal virtual networks by default.
- Allow NAT only for updates, then disable it when exercises begin.
- Change default passwords immediately.
- Keep Wazuh active response disabled until rules are tuned and rollback is tested.
- Snapshot lab VMs before major changes.


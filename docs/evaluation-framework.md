# Evaluation Framework

This document defines a repeatable academic evaluation plan for the private SOC lab.

## Evaluation Goal

The evaluation measures whether the lab can support realistic SOC learning outcomes: collecting telemetry, detecting security events, correlating evidence, documenting triage decisions, and selecting proportionate response actions.

## Hypothesis

An isolated virtual SOC environment that combines host-based telemetry from Wazuh, network telemetry from Security Onion, and independent log search through ELK can provide sufficient visibility and workflow structure for practical security monitoring and incident response training.

## Independent Variables

| Variable | Values |
| --- | --- |
| Detection source | Wazuh, Security Onion, ELK Lite |
| Event type | Authentication, network scan, process execution, file change, DNS/network metadata, synthetic validation |
| Rule state | Default rules, tuned rules |
| Endpoint type | Windows, Linux |
| Data source | Host logs, network metadata, IDS alerts, synthetic JSON/syslog |

## Dependent Variables

| Metric | Measurement method |
| --- | --- |
| Detection coverage | Count of scenarios with at least one relevant alert or searchable event divided by total scenarios. |
| Mean time to detection | Difference between scenario start timestamp and first relevant alert/event timestamp. |
| Mean time to triage | Difference between first alert review and classification decision. |
| False positive count | Count of irrelevant alerts during a defined baseline period. |
| Evidence completeness score | Checklist score based on required evidence fields. |
| Tool complementarity | Qualitative comparison of what each tool contributed to the investigation. |

## Evidence Completeness Rubric

Score each scenario from 0 to 10.

| Evidence element | Points |
| --- | ---: |
| Accurate timestamp | 1 |
| Affected host | 1 |
| Source IP or user | 1 |
| Destination IP or service | 1 |
| Process, command, or event source | 1 |
| Rule name or detection logic | 1 |
| Severity or priority | 1 |
| Raw event available | 1 |
| Pivot path to related events | 1 |
| Clear response recommendation | 1 |

## Experiment Matrix

| ID | Scenario | Tool expectation | Success criteria | Key metrics |
| --- | --- | --- | --- | --- |
| E01 | Synthetic JSON event sent to Logstash | ELK Lite | Event appears in `soc-lab-*` and can be searched in Kibana. | Ingestion success, MTTD |
| E02 | Repeated failed SSH logins | Wazuh, Security Onion | Wazuh identifies authentication failures; Security Onion shows related connections if traffic crosses the sensor. | Coverage, alert fidelity, MTTD |
| E03 | Port scan from lab test workstation | Security Onion | Suricata/Zeek evidence identifies scanner, target, ports, and time window. | Coverage, evidence completeness |
| E04 | Sensitive file modification | Wazuh | FIM alert identifies file path, host, time, and change context. | Coverage, evidence completeness |
| E05 | Suspicious PowerShell command line | Wazuh | Endpoint event includes user, command line, parent process if available, and host. | Coverage, alert fidelity |
| E06 | DNS anomaly exercise | Security Onion, ELK Lite | Zeek DNS metadata is searchable and supports timeline reconstruction. | Evidence completeness, triage time |

## Baseline Procedure

1. Start all lab services.
2. Confirm time synchronization across hosts.
3. Record tool versions and VM resource allocation.
4. Run a 30-60 minute quiet baseline with normal logins, package updates, and light browsing inside the lab.
5. Record background alert volume.
6. Classify baseline alerts as expected, noisy, suspicious, or unknown.

## Scenario Procedure

For each experiment:

1. Record scenario ID, date, start time, endpoint, source host, and expected behavior.
2. Execute the benign test action.
3. Record the first relevant alert/event time in each tool.
4. Capture screenshots or exported evidence with synthetic data only.
5. Complete the evidence completeness rubric.
6. Record analyst triage notes and classification.
7. Reset the environment or document remaining state.

## Rule Tuning Procedure

1. Run baseline and scenario tests using default rules.
2. Identify noisy rules, missing context, and missed detections.
3. Apply narrow tuning changes.
4. Re-run the same tests.
5. Compare default and tuned results.

Do not suppress alerts broadly. Every tuning decision must include a reason and expected effect.

## Results Tables

### Detection Coverage

| Scenario | Wazuh | Security Onion | ELK Lite | Overall result |
| --- | --- | --- | --- | --- |
| E01 Synthetic JSON | Not applicable | Not applicable |  |  |
| E02 SSH failures |  |  | Optional |  |
| E03 Port scan | Optional |  | Optional |  |
| E04 File modification |  | Not applicable | Optional |  |
| E05 PowerShell command |  | Optional | Optional |  |
| E06 DNS anomaly | Not applicable |  | Optional |  |

### Timing

| Scenario | Start time | First alert time | MTTD | Triage start | Classification time | MTTT |
| --- | --- | --- | ---: | --- | --- | ---: |
| E01 |  |  |  |  |  |  |
| E02 |  |  |  |  |  |  |
| E03 |  |  |  |  |  |  |
| E04 |  |  |  |  |  |  |
| E05 |  |  |  |  |  |  |
| E06 |  |  |  |  |  |  |

### Evidence Completeness

| Scenario | Score before tuning | Score after tuning | Notes |
| --- | ---: | ---: | --- |
| E01 |  |  |  |
| E02 |  |  |  |
| E03 |  |  |  |
| E04 |  |  |  |
| E05 |  |  |  |
| E06 |  |  |  |

## Analysis Guidance

The discussion should avoid claiming that the lab proves enterprise-grade SOC effectiveness. Instead, analyze:

- Which data sources were sufficient for each scenario.
- Where correlation across tools improved understanding.
- Which events produced too much or too little context.
- Which tuning changes improved fidelity.
- Which limitations are caused by virtualization, tool defaults, or missing telemetry.
- How the lab supports academic learning outcomes.

## Validity Considerations

| Validity concern | Mitigation |
| --- | --- |
| Tool version changes | Record exact versions and configuration snapshots. |
| Scenario artificiality | Use benign scenarios mapped to real defensive frameworks. |
| Small environment size | State that results apply to training and small-lab contexts, not enterprise performance. |
| Observer bias during triage | Use predefined scoring rubrics and repeat scenarios. |
| Incomplete telemetry | Document all enabled and missing log sources. |


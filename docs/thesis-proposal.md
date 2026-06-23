# Thesis Proposal

## Proposed Title

Design, Implementation, and Evaluation of an Isolated Virtual Security Operations Center for Security Monitoring, Detection, and Incident Response Training

## Alternative Titles

- A Framework for Building and Evaluating a Virtual SOC Lab Using Wazuh, Security Onion, and ELK
- Evaluating Host-Based and Network-Based Detection Capabilities in an Isolated Virtual SOC Environment
- Development of a Low-Cost Virtual SOC Environment for Cybersecurity Monitoring and Incident Response Education

## Abstract

Security Operations Centers (SOCs) play a central role in the detection, analysis, and response to cybersecurity incidents. However, access to realistic SOC infrastructure can be limited by cost, complexity, privacy concerns, and the operational risk of experimenting in production environments. This thesis proposes the design, implementation, and evaluation of an isolated virtual SOC environment that integrates Wazuh, Security Onion, and the Elastic Stack to support security event monitoring, detection engineering, incident triage, and response workflow training.

The research will construct a controlled lab environment consisting of endpoint telemetry, network-based monitoring, centralized log ingestion, alerting, investigation workflows, and documented response playbooks. The environment will be evaluated through a set of benign, repeatable security scenarios mapped to recognized cybersecurity frameworks, including NIST Cybersecurity Framework 2.0, NIST SP 800-61 Revision 3, and MITRE ATT&CK Enterprise. Evaluation will focus on detection coverage, alert fidelity, event correlation, mean time to detection, mean time to triage, false positive behavior, and the operational usefulness of the generated evidence.

The expected contribution is a reproducible, low-cost academic SOC lab model and an evaluation methodology that can be used for cybersecurity education, blue-team training, and early-stage detection engineering research.

## Problem Statement

Many cybersecurity students and early-career analysts study monitoring, detection, and incident response primarily through theoretical material or isolated tool demonstrations. This creates a gap between conceptual understanding and the practical skills required to operate a SOC workflow: collecting telemetry, validating alerts, correlating host and network evidence, documenting incidents, and selecting proportionate response actions.

Commercial SOC environments and enterprise SIEM deployments are often inaccessible to learners because they require significant infrastructure, licensing, sensitive data, and operational expertise. At the same time, simple single-tool demonstrations do not adequately represent the relationship between endpoint monitoring, network monitoring, centralized log analysis, and structured incident response.

This thesis addresses the problem by designing and evaluating a private virtual SOC lab that provides realistic monitoring and response practice while remaining isolated, reproducible, and suitable for academic use.

## Aim

The aim of this research is to design, implement, and evaluate an isolated virtual SOC environment that supports practical security monitoring, detection, investigation, and incident response training using open and widely available security tools.

## Objectives

1. Design a private virtual SOC architecture that integrates host-based monitoring, network-based monitoring, centralized logging, and response documentation.
2. Implement the environment using Wazuh, Security Onion, and the Elastic Stack in a controlled virtual lab.
3. Develop benign, repeatable test scenarios representing common security events and adversary behaviors.
4. Map the test scenarios and detection logic to recognized frameworks such as MITRE ATT&CK Enterprise and NIST incident response guidance.
5. Evaluate the environment using measurable criteria including detection coverage, alert quality, false positives, mean time to detection, and mean time to triage.
6. Produce operational documentation, response playbooks, and a reproducible implementation package suitable for academic and training use.

## Research Questions

### Primary Research Question

How effective is an isolated virtual SOC environment using Wazuh, Security Onion, and ELK for supporting practical security monitoring, detection, and incident response training?

### Secondary Research Questions

1. What types of host-based and network-based security events can be detected reliably in the proposed lab architecture?
2. How do Wazuh, Security Onion, and ELK complement one another during alert validation and incident investigation?
3. What detection gaps or operational limitations appear when evaluating common security scenarios in a virtualized SOC environment?
4. How does rule tuning affect alert fidelity and false positive rates in the lab?
5. Can documented playbooks improve consistency and efficiency during triage and response exercises?

## Scope

This thesis focuses on defensive monitoring and response in a private, isolated virtual environment. The scope includes:

- Deployment of Wazuh for endpoint telemetry and host-based alerting.
- Deployment of Security Onion for network monitoring, alerting, packet/metadata analysis, and case workflow.
- Deployment of a lightweight ELK stack for independent log ingestion, search, and dashboard practice.
- Design of benign security scenarios such as authentication failures, network scanning, suspicious scripting, file integrity changes, and synthetic validation events.
- Evaluation of detection and response workflow using measurable criteria.

The scope excludes:

- Production SOC deployment.
- Real malware execution outside a controlled malware-analysis environment.
- Unauthorized monitoring or testing.
- Offensive exploitation against third-party systems.
- Enterprise-scale performance benchmarking.

## Research Methodology

The thesis will use a design science methodology. The research artifact is the virtual SOC environment, including its architecture, deployment files, detection scenarios, response playbooks, and evaluation framework.

The methodology consists of five phases:

1. Requirements analysis: Identify functional and non-functional requirements for a private academic SOC lab.
2. System design: Define the virtual network topology, tool roles, data flows, trust boundaries, and operational workflow.
3. Implementation: Deploy and configure Wazuh, Security Onion, and ELK within an isolated lab.
4. Experimental evaluation: Execute repeatable test scenarios and collect detection, triage, and response metrics.
5. Analysis and refinement: Identify detection gaps, tune rules, compare pre-tuning and post-tuning results, and document limitations.

## Conceptual Framework

The research aligns the lab workflow with recognized defensive security frameworks:

| Framework | Use in thesis |
| --- | --- |
| NIST Cybersecurity Framework 2.0 | Structures the high-level functions of govern, identify, protect, detect, respond, and recover. |
| NIST SP 800-61 Revision 3 | Provides incident response recommendations and considerations for preparation, detection, response, and recovery. |
| MITRE ATT&CK Enterprise | Maps test scenarios to adversary tactics and techniques for detection coverage analysis. |

## Proposed Lab Architecture

The lab will include:

- Endpoint subnet containing Windows and Linux hosts.
- SOC services subnet containing Wazuh and ELK Lite.
- Security Onion VM with a management interface and a separate sniffing interface.
- Optional test workstation used only to generate benign validation activity.
- Strict network isolation using host-only, internal, or NAT-limited virtual networking.

The architecture supports both host telemetry and network telemetry, enabling comparison between endpoint-based and network-based detection sources.

## Test Scenarios

| Scenario | Primary tool | Example framework mapping | Evaluation focus |
| --- | --- | --- | --- |
| Repeated SSH login failures | Wazuh, Security Onion | Credential Access / brute force behavior | Detection time, source attribution, alert volume |
| Port scan against lab host | Security Onion | Discovery | Network visibility, alert clarity, event correlation |
| Suspicious PowerShell command line | Wazuh | Execution: PowerShell | Endpoint visibility, rule specificity |
| Sensitive file modification | Wazuh | Defense Evasion or Impact context-dependent behavior | FIM accuracy, evidence quality |
| Synthetic JSON validation event | ELK Lite | Not applicable | Pipeline reliability and dashboard visibility |
| DNS anomaly exercise | Security Onion, ELK Lite | Command and Control-like indicator pattern | Metadata usefulness and pivoting workflow |

All scenarios should use benign commands and synthetic data unless the university explicitly approves a more controlled malware-analysis setting.

## Evaluation Metrics

| Metric | Definition |
| --- | --- |
| Detection coverage | Percentage of planned scenarios that generate useful alerts or searchable evidence. |
| Mean time to detection | Time between scenario execution and first relevant alert/event availability. |
| Mean time to triage | Time required to classify an alert as false positive, suspicious, or confirmed incident. |
| Alert fidelity | Degree to which the alert contains enough context for investigation. |
| False positive rate | Number of irrelevant alerts generated during controlled baseline activity. |
| Evidence completeness | Availability of host, network, timestamp, user, process, source, and destination context. |
| Response playbook usefulness | Whether the playbook enables consistent analyst action and documentation. |

## Expected Contribution

The thesis is expected to contribute:

- A reproducible virtual SOC architecture suitable for academic and private training environments.
- A documented integration model for Wazuh, Security Onion, and ELK.
- A structured detection and response evaluation framework.
- A set of mapped, benign test scenarios for SOC training.
- Practical findings on the strengths and limitations of combining host-based and network-based monitoring tools in a low-cost virtual lab.

## Ethical And Legal Considerations

The research will be conducted only within private, isolated virtual environments. No third-party systems, public networks, or production assets will be targeted. All test data should be synthetic or generated from owned lab systems. Any screenshots, logs, packet captures, or evidence included in the thesis must be reviewed to remove credentials, private IP details if required by policy, hostnames, personal data, and secrets.

Automated response must remain disabled by default. If active response is tested, it should be limited to disposable lab hosts and reversible containment actions.

## Limitations

Expected limitations include:

- The lab does not reproduce the scale, organizational complexity, or data diversity of a production SOC.
- Virtual network traffic may not fully represent enterprise traffic patterns.
- Tool defaults may generate different results across versions.
- Detection accuracy depends heavily on rule configuration, log source quality, and endpoint instrumentation.
- The evaluation scenarios represent selected common behaviors rather than a comprehensive attack corpus.

## Proposed Chapter Structure

1. Introduction
   - Background
   - Problem statement
   - Aim and objectives
   - Research questions
   - Scope and limitations

2. Literature Review
   - SOC concepts and responsibilities
   - SIEM and log management
   - Endpoint detection and host monitoring
   - Network security monitoring
   - Incident response frameworks
   - MITRE ATT&CK and detection coverage
   - Cybersecurity education and virtual labs

3. Methodology
   - Research design
   - Lab requirements
   - Tool selection rationale
   - Experimental design
   - Metrics and data collection
   - Ethical considerations

4. System Design and Implementation
   - Architecture
   - Network topology
   - Wazuh deployment
   - Security Onion deployment
   - ELK Lite deployment
   - Logging and data flow
   - Response playbooks

5. Evaluation and Results
   - Test scenario execution
   - Detection coverage results
   - Alert quality analysis
   - Triage and response observations
   - Pre-tuning and post-tuning comparison

6. Discussion
   - Interpretation of results
   - Strengths of the architecture
   - Detection and operational gaps
   - Educational usefulness
   - Practical recommendations

7. Conclusion
   - Summary of findings
   - Research contribution
   - Limitations
   - Future work

## Preliminary References

- National Institute of Standards and Technology. Cybersecurity Framework 2.0. https://www.nist.gov/cyberframework
- National Institute of Standards and Technology. NIST SP 800-61 Revision 3: Incident Response Recommendations and Considerations for Cybersecurity Risk Management: A CSF 2.0 Community Profile. https://csrc.nist.gov/pubs/sp/800/61/r3/final
- MITRE. MITRE ATT&CK Enterprise Matrix. https://attack.mitre.org/matrices/enterprise/
- Wazuh. Wazuh Docker Deployment Documentation. https://documentation.wazuh.com/current/deployment-options/docker/wazuh-container.html
- Wazuh. Wazuh Active Response Documentation. https://documentation.wazuh.com/current/user-manual/capabilities/active-response/index.html
- Elastic. Install Elasticsearch with Docker Compose. https://www.elastic.co/docs/deploy-manage/deploy/self-managed/install-elasticsearch-docker-compose
- Security Onion Solutions. Security Onion Documentation. https://securityonion.net/docs/


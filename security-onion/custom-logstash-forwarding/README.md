# Security Onion To ELK Lite Forwarding

Security Onion already includes its own storage, Hunt, dashboards, and cases. Forwarding to ELK Lite is optional and mainly useful for learning raw Logstash/Elasticsearch/Kibana workflows outside the Security Onion-managed stack.

## Lab Flow

```text
Security Onion Logstash custom output -> ELK Lite Logstash :5514 -> soc-lab-* index
```

## Install The Example

On the Security Onion manager:

```bash
sudo mkdir -p /opt/so/saltstack/local/salt/logstash/pipelines/config/custom/
sudo cp zeek-dns-to-elk.conf /opt/so/saltstack/local/salt/logstash/pipelines/config/custom/
sudo vi /opt/so/saltstack/local/salt/logstash/pipelines/config/custom/zeek-dns-to-elk.conf
sudo salt-call state.apply Logstash
```

Replace `ELK_HOST_ONLY_IP` with the private IP of the host running ELK Lite. Keep the port restricted to private lab subnets.

## Validate

1. In ELK Lite, confirm Logstash is running:

   ```powershell
   docker logs soc-elk-logstash --tail 50
   ```

2. Generate DNS traffic from a lab endpoint.
3. In Kibana, create or open the `soc-lab-*` data view.
4. Search for `event.module: Zeek` or `pipeline: dns`.


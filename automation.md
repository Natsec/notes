# Infrastructure automation

## Ansible

`ansible.cfg` :
```ini
[defaults]
inventory = ./hosts

callback_enabled = timer
stdout_callback = debug

# cache facts locally for 1 hour
gathering = smart
fact_caching = yaml
fact_caching_connection = facts.yaml
fact_caching_timeout = 3600

[ssh_connection]
pipelining = true
```

Restart firewall [without hanging](https://docs.ansible.com/ansible/latest/user_guide/playbooks_async.html) in `roles/myrole/handlers/main.yml` :
```yaml
- name: restart nftables
  shell:
    cmd: systemctl restart nftables
  async: 4
  poll: 0
```

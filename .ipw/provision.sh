#!/bin/bash
pacman -Sy puppet --noconfirm --needed
/bin/cat <<EOF >/etc/puppetlabs/puppet/puppet.conf
[main]
certname={{.Hostname}}
server={{.Server}}
environment=production
csr_attributes=/etc/puppetlabs/puppet/csr_attributes.yaml
EOF
/bin/cat <<EOF >/etc/puppetlabs/puppet/csr_attributes.yaml
---
custom_attributes:
        1.2.840.113549.1.9.7: {{.AuthKey}}
EOF
puppet agent -w 60 --no-daemonize -v -o --server puppet
/bin/bash

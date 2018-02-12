#!/bin/bash
/bin/cat <<EOF >/etc/puppetlabs/puppet/puppet.conf
[main]
server={{.Server}}
masterport=443
environment=production
storeconfigs=false
csr_attributes=/etc/puppetlabs/puppet/csr_attributes.yaml
EOF
/bin/cat <<EOF >/etc/puppetlabs/puppet/csr_attributes.yaml
---
custom_attributes:
        1.2.840.113549.1.9.7: {{.UUID}}
EOF
puppet agent -w 60 --no-daemonize -v -o

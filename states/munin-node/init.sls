munin-node:
  pkg:
    - installed

append_line:
  file.replace:
   - name: /etc/munin/munin-node.conf
   - pattern: '127\\.0\\.0\\.1'
   - repl: '10\.0\.7\.163'

munin-node_restart:
  cmd.run:
   - name: systemctl restart munin-node

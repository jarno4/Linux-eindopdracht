munin-node:
 pkg: 
   - installed 

#append line: 
#  file.replace: 
#     - name: /etc/munin/munin-node.conf 
#     - pattern: '127\\.0\\.0\\.1' 
#     - repl: '10\.0\.7\.129'

#file.append:
   #- name: /etc/munin/munin-node.conf 
   #- pattern: 'allow ^127\.0\.7\.1$' 
   #- text: 'allow ^10\.0\.0\.129$'

#munin-node restart: 
#  service.running: 
#    - name: munin-node
#    - reload: True

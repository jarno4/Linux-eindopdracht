rsyslog:
  pkg:
    - installed

/etc/rsyslog.conf: 
  file.append:
   - text: |
       $PreserveFQDN on 
       *.* @10.0.7.164:514
       *.* @@10.0.7.164:514 
       $ActionQueueFileName queue
       $ActionQueueMaxDiskSpace 1g
       $ActionQueueSaveOnShutdown on
       $ActionQueueType LinkedList
       $ActionResumeRetryCount -1
 
rsyslog_restart: 
  cmd.run:
    - name: systemctl restart rsyslog

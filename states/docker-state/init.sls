docker_installation:
 
  pkg.latest:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - curl 
      - gnupg-agent
      - software-properties-common

  cmd.run:
    - name: |
       curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
       apt-key fingerprint 0EBFCD88
       add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
       apt update -y
       apt-cache policy docker-ce -y
       apt install docker-ce -y
       docker run hello-world
      

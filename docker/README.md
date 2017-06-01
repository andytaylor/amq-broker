
#Creating an Ansible Docker Image
These scripts will create a docker image for Fedora with ssh enabled and will set up 
the ansible ssh so ansible can work. Before building the docker image you will need to create a file called authorized_keys
and copy the public key of the Ansible host into it, you can do this by running the following command in the docker directory:

 ```
cat ~/.ssh/id_rsa.pub | tee authorized_keys
``` 

by default the key can be found in ~/.ssh/id_rsa.pub. 
This will allow Ansible to connect to the Docker Container. 

Once you can build the Docker image by running the command

```
docker build -t ansible
```

You can then run 1 or more Docker containers by running:

```
docker run -d --name ansible1 -h ansible1 ansible
```

or if you want to interact with the container and manually start ssh ru
```
docker run -name ansible1  ansible /bin/bash
```

and then

```
/usr/sbin/sshd -D
```

changing the name ansible1 to ansible2, ansible3 etc for however many containers you need. 

you can then stop/start the container using the commands:

```
docker stop ansible
```
and
```
docker start ansible
```

# Using Ansible with your containers

The first thing to do is to add the containers ip address to the ansible hosts file. The utility script resolve_ip.sh can
  be used to find out what the entry should be, running it will show something like:
```
./resolve_ip.sh ansible1
172.18.0.2  ansible1    
```
then just add the output into the /etc/hosts file
If this script doesn't work then use the resolve_ip2.sh script.

You can then test the container by ssh'ing to it using

```
ssh ansible@ansible1 
```

You then need to add the container to the Ansible hosts, edit the /etc/ansible/hosts file and add

```ansible1 ansible_user=ansible```


you can then check that the container is accessible by Ansible by running 

```ansible all -m ping```

You should see something like:

```
ansible1 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
```
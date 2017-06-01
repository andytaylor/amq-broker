FROM docker.io/fedora:25
MAINTAINER http://fedoraproject.org/wiki/Cloud

# Atomic RUN label, enables the atomic cli
LABEL RUN='docker run --name ssh -d -p 2200:22 $IMAGE'

EXPOSE 22

RUN dnf -y update && dnf -y install openssh-server passwd && dnf clean all
RUN dnf -y install yum
RUN dnf install -y python2 python2-dnf libselinux-python
RUN useradd ansible
RUN echo "ansible" | passwd --stdin ansible
RUN su ansible
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN su ansible -c "mkdir /home/ansible/.ssh "
RUN su ansible -c "ssh-keygen -t rsa -f /home/ansible/.ssh/id_rsa -N '' "
ADD authorized_keys /home/ansible/.ssh/authorized_keys
RUN chown ansible:ansible /home/ansible/.ssh/authorized_keys
RUN su ansible -c "chmod 700 /home/ansible/.ssh  "
RUN su ansible -c "chmod 600 /home/ansible/.ssh/authorized_keys"
CMD /usr/sbin/sshd -D
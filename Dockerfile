FROM ubuntu:trusty
MAINTAINER Viktor Miroshnikov <viktor@flowhealth.com>

RUN apt-get update -q && apt-get -q -y upgrade
RUN apt-get install -y tar gzip openssh-server
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/#PasswordAuthentication\s+.*/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /var/run/sshd 
RUN ln -s /var/sync/dot-ssh /root/.ssh
EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]

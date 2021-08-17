FROM ubuntu:18.04
EXPOSE 22
RUN adduser --quiet --system jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    mkdir -p /home/jenkins/.m2
COPY authorized_keys /home/jenkins/.ssh/authorized_keys
RUN chown -R jenkins:jenkins /home/jenkins/.m2/
RUN chown -R jenkins:jenkins /home/jenkins/.ssh/
WORKDIR /home/jenkins
RUN apt update
RUN apt -qy full-upgrade
RUN apt install -qy git openssh-server openjdk-8-jdk maven
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd
RUN apt -qy autoremove
CMD ["/usr/sbin/sshd", "-D"]

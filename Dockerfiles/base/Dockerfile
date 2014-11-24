FROM centos:centos6

# ---------------------------------------
#  System Env
# ---------------------------------------
ENV HOSTNAME docker_test01
# Bash
RUN echo "export PS1='[\u@\h \W]$ ' " >> /etc/profile
RUN echo "set -o vi"                  >> /etc/profile
# TimeZone
RUN echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# Locale
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8
RUN sed -ri 's/en_US/ja_JP/' /etc/sysconfig/i18n

# ---------------------------------------
#  Packages
# ---------------------------------------
RUN yum -y install      \
        openssh-clients \
        openssh-server  \
        sudo  \
        ntp   \
        git   \
        vim-enhanced \
        which \
        wget

# ---------------------------------------
#  User/Group Add
# ---------------------------------------
RUN groupadd -g 1000 dev
# Sudo
RUN echo '%dev  ALL=(ALL)   NOPASSWD: ALL' > /etc/sudoers.d/group-dev
# Useradd
RUN useradd -u 500 -g dev -G wheel hoge

# ---------------------------------------
#  Authentication
# ---------------------------------------
# Password
RUN echo 'root:password' | chpasswd 
RUN echo 'hoge:hoge' | chpasswd hoge
# SSH
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
RUN mkdir -m 700 /home/hoge/.ssh
RUN chown hoge:dev /home/hoge/.ssh

# ---------------------------------------
#  Port
# ---------------------------------------
# sshポート
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

# Note:
# - Docker Manual
# http://docs.docker.com/examples/running_ssh_service/
# - Local Error on CentOS7
# http://weblabo.oscasierra.net/vagrant-centos6-japanize/

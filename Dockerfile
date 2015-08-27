FROM ubuntu:15.04
MAINTAINER 74th<site@j74th.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget git

# install mono
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mono-complete

# install nuget
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nuget

# install jenkins
ADD https://jenkins-ci.org/debian/jenkins-ci.org.key /root/jenkins-ci.org.key
RUN apt-key add - < /root/jenkins-ci.org.key
RUN sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y jenkins

# install plugins 
ADD ./InstallPlugins.sh /root/ 
RUN sh /root/InstallPlugins.sh

# msbuild.exe
RUN ln -s /usr/bin/xbuild /usr/bin/msbuild.exe

# jenkins port
EXPOSE 8080

# jenkins home
# VOLUME /var/lib/jenkins
# VOLUME /var/log/jenkins

# RUN echo "hoge" > /var/log/jenkins/jenkins.log
# RUN chown jenkins:jenkins /var/log/jenkins/jenkins.log
ENTRYPOINT touch /var/log/jenkins/jenkins.log | chown jenkins:jenkins /var/log/jenkins/jenkins.log | service jenkins start | tail -f /var/log/jenkins/jenkins.log

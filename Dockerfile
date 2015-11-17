FROM jenkins:latest

USER root

# add jenkins plugins
RUN mkdir -p /tmp/WEB-INF/plugins

RUN curl -L https://updates.jenkins-ci.org/latest/scm-api.hpi -o /tmp/WEB-INF/plugins/scm-api.hpi
RUN curl -L https://updates.jenkins-ci.org/latest/ruby-runtime.hpi -o /tmp/WEB-INF/plugins/ruby-runtime.hpi
RUN curl -L https://updates.jenkins-ci.org/latest/git.hpi -o /tmp/WEB-INF/plugins/git.hpi
RUN curl -L https://updates.jenkins-ci.org/latest/git-client.hpi -o /tmp/WEB-INF/plugins/git-client.hpi
RUN curl -L https://updates.jenkins-ci.org/latest/gitlab-hook.hpi -o /tmp/WEB-INF/plugins/gitlab-hook.hpi

RUN cd /tmp; \
  zip --grow /usr/share/jenkins/jenkins.war WEB-INF/plugins/scm-api.hpi && \
  zip --grow /usr/share/jenkins/jenkins.war WEB-INF/plugins/ruby-runtime.hpi && \
  zip --grow /usr/share/jenkins/jenkins.war WEB-INF/plugins/git.hpi && \
  zip --grow /usr/share/jenkins/jenkins.war WEB-INF/plugins/git-client.hpi && \
  zip --grow /usr/share/jenkins/jenkins.war WEB-INF/plugins/gitlab-hook.hpi

# install php
RUN apt-get update
RUN apt-get -y -f install php5-cli php5-dev php5-curl php5-mysql ant

# install composer
RUN mkdir /home/jenkins
RUN chown jenkins:jenkins /home/jenkins

USER jenkins

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/home/jenkins

# clean up
USER root
RUN apt-get clean -y

USER jenkins

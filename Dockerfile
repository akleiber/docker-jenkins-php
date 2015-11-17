FROM jenkins:latest

USER root

# install php
RUN apt-get update
RUN apt-get -y -f install php5-cli php5-dev php5-curl

# install composer
RUN mkdir /home/jenkins
RUN chown jenkins:jenkins /home/jenkins

USER jenkins

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/home/jenkins

# clean up
USER root
RUN apt-get clean -y

USER jenkins

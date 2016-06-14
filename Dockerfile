FROM maven:3.2.5-jdk-8

ADD jcenter.settings.xml /usr/share/maven/conf/settings.xml
ADD .npmrc /

RUN mkdir -p /.npm && chmod 777 /.npm 

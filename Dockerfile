FROM ubuntu:16.04
RUN apt-get update && apt-get install -y default-jdk curl
RUN groupadd tomcat
RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
RUN cd /tmp
RUN curl -O https://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.57/bin/apache-tomcat-8.5.57.tar.gz
#RUN mkdir /opt/tomcat
RUN mkdir /opt/tomcat
RUN tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
WORKDIR /opt/tomcat
RUN chgrp -R tomcat /opt/tomcat
RUN chmod -R g+r conf
RUN chmod g+x conf
RUN chown -R tomcat webapps/ work/ temp/ logs/ bin/
COPY ./tomcat-users.xml /opt/tomcat/conf/
COPY target/demo.war /opt/tomcat/webapps/
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
#CMD ["/opt/tomcat/bin/startup.sh", "run"]
EXPOSE 8080

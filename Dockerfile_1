FROM tomcat:8.5
RUN apt-get update 
RUN apt-get install -y vim
COPY target/demo.war /usr/local/tomcat/webapps/demo.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

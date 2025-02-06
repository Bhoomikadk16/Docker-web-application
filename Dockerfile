FROM tomcat:9-jre9
COPY ./target/docweb.war /usr/local/tomcat/webapps/
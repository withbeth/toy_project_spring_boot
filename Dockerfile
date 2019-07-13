FROM openjdk:8-jdk-alpine

#"/tmp" is where a Spring Boot application creates working directories for Tomcat by default.
# The effect is to create a temporary file on your host under "/var/lib/docker" and
# link it to the container under "/tmp".
VOLUME /tmp
ARG JAR_FILE
COPY ${JAR_FILE} app.jar
# To reduce Tomcat startup time
# we added a system property pointing to "/dev/urandom" as a source of entropy.
# This is not necessary with more recent versions of Spring Boot,
# if you use the "standard" version of Tomcat (or any other web server).
ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar
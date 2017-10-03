FROM jenkins/jenkins:alpine
USER root
RUN apk --no-cache add docker maven
RUN delgroup docker && \
    addgroup -g 991 docker && \
    adduser jenkins docker
USER jenkins

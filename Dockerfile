#ARG MAVEN_IMAGE=maven:3-eclipse-temurin-11-alpine

ARG MANDREL_IMAGE=quay.io/quarkus/ubi-quarkus-mandrel:22.1-java11

#FROM ${MAVEN_IMAGE} AS maven

FROM ${MANDREL_IMAGE}

ARG MAVEN_BINARY_URL=https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz

USER root

ENV MAVEN_HOME=/opt/maven
ENV M2_HOME=/opt/maven
ENV PATH="${MAVEN_HOME}/bin:${PATH}"
ENV MAVEN_OPTS="-Xmx1024m -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8"


#COPY --from=maven /usr/share/maven ${MAVEN_HOME}


RUN microdnf upgrade && microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y bash curl wget \
    && mkdir -p /opt/maven && curl -fL $MAVEN_BINARY_URL | tar zxv -C /opt/maven --strip-components=1 \
    && microdnf clean all && [ ! -d /var/cache/yum ] || rm -rf /var/cache/yum


#WORKDIR /drone/src

ENTRYPOINT []
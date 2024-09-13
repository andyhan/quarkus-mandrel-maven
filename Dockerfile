ARG MANDREL_IMAGE=quay.io/quarkus/ubi-quarkus-mandrel-builder-image:jdk-21

FROM ${MANDREL_IMAGE}

ARG MAVEN_VERSION=3.9.9
ARG MVND_VERSION=1.0.2

ENV MAVEN_BINARY_URL=https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
ENV MVND_BINARY_URL=https://downloads.apache.org/maven/mvnd/${MVND_VERSION}/maven-mvnd-${MVND_VERSION}-linux-amd64.tar.gz

ENV MAVEN_HOME=/opt/maven
ENV M2_HOME=/opt/maven
ENV MVND_HOME=/opt/mvnd
ENV PATH="${MVND_HOME}/bin:${MAVEN_HOME}/bin:${PATH}"
ENV MAVEN_OPTS="-Xmx1024m -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8"

USER root

RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y bash curl \
    && mkdir -p /opt/maven && curl -fL $MAVEN_BINARY_URL | tar zxv -C /opt/maven --strip-components=1 \
    && mkdir -p /opt/mvnd && curl -fL $MVND_BINARY_URL | tar zxv -C /opt/mvnd --strip-components=1 \ 
    && ln -s ${MAVEN_HOME}/bin/mvn /usr/bin/mvn \
    && ln -s ${MVND_HOME}/bin/mvnd /usr/bin/mvnd \
    && microdnf clean all && [ ! -d /var/cache/yum ] || rm -rf /var/cache/yum

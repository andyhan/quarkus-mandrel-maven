ARG MANDREL_IMAGE=quay.io/quarkus/ubi-quarkus-mandrel-builder-image:23.1-java21

FROM ${MANDREL_IMAGE}

ARG MAVEN_BINARY_URL=https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz

USER root

ENV MAVEN_HOME=/opt/maven
ENV M2_HOME=/opt/maven
ENV PATH="${MAVEN_HOME}/bin:${PATH}"
ENV MAVEN_OPTS="-Xmx1024m -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8"

RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y bash curl \
    && mkdir -p /opt/maven && curl -fL $MAVEN_BINARY_URL | tar zxv -C /opt/maven --strip-components=1 \
    && microdnf clean all && [ ! -d /var/cache/yum ] || rm -rf /var/cache/yum

ENTRYPOINT []

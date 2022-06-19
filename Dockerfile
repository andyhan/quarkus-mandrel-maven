ARG MAVEN_IMAGE=maven:3-eclipse-temurin-11-alpine
ARG MANDREL_IMAGE=quay.io/quarkus/ubi-quarkus-mandrel:22.1-java11

FROM ${MAVEN_IMAGE} AS maven

FROM ${MANDREL_IMAGE}

USER root

ENV MAVEN_HOME=/opt/maven
ENV PATH="${PATH}:${MAVEN_HOME}/bin"

COPY --from=maven /usr/share/maven ${MAVEN_HOME}

RUN microdnf module enable -y nodejs:16 && microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y bash curl nodejs npm \
    && curl -fsSL https://get.pnpm.io/install.sh | sh - \
    && npm install -g npm yarn \
    && microdnf clean all && [ ! -d /var/cache/yum ] || rm -rf /var/cache/yum

WORKDIR /drone/src

ENTRYPOINT []
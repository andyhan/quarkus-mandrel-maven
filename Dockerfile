ARG MAVEN_IMAGE=maven:3-eclipse-temurin-11-alpine
ARG MANDREL_IMAGE=quay.io/quarkus/ubi-quarkus-mandrel:22.1-java11

FROM ${MAVEN_IMAGE} AS maven

FROM ${MANDREL_IMAGE}

ENV MAVEN_HOME=/opt/maven \
    PATH="${PATH}:${MAVEN_HOME}/bin"
    
USER root

COPY --from=maven /usr/share/maven ${MAVEN_HOME}

# RUN ln -s /opt/maven/bin/mvn /usr/bin/mvn

USER 1001

ENTRYPOINT []
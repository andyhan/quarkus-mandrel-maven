ARG MANDREL_IMAGE=quay.io/quarkus/ubi-quarkus-mandrel:22.1-java11-amd64
ARG MAVEN_IMAGE=maven:3-eclipse-temurin-11-alpine
ARG NODE_IMAGE=andyhan/nodejs-builder:16

FROM ${MAVEN_IMAGE} AS maven
FROM ${MANDREL_IMAGE} AS mandrel

FROM ${NODE_IMAGE}

ENV M2_HOME=/opt/maven
ENV GRAALVM_HOME=/opt/mandrel
ENV JAVA_HOME=/opt/mandrel
ENV PATH="${JAVA_HOME}/bin:${M2_HOME}/bin:${PATH}"

# COPY --from=maven $JAVA_HOME $JAVA_HOME
COPY --from=mandrel $JAVA_HOME $JAVA_HOME
COPY --from=maven /usr/share/maven ${M2_HOME}

ENTRYPOINT ["native-image"]
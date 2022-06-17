ARG MAVEN_IMAGE=maven:3-eclipse-temurin-11-alpine
ARG NODE_IMAGE=andyhan/nodejs-builder:16

FROM ${MAVEN_IMAGE} AS maven

FROM ${NODE_IMAGE}

ENV M2_HOME=/opt/maven
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${M2_HOME}/bin:${PATH}"

COPY --from=maven $JAVA_HOME $JAVA_HOME
COPY --from=maven /usr/share/maven ${M2_HOME}

ENTRYPOINT []
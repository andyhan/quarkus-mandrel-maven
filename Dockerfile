ARG MANDREL_IMAGE=quay.io/quarkus/ubi-quarkus-mandrel:22.1-java11-amd64
ARG MAVEN_IMAGE=maven:3-eclipse-temurin-11-alpine

FROM ${MAVEN_IMAGE} AS maven
FROM ${MANDREL_IMAGE}

ENV M2_HOME=/opt/maven
ENV PATH="${M2_HOME}/bin:${PATH}"

COPY --from=maven /usr/share/maven ${M2_HOME}

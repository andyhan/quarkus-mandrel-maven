FROM quay.io/quarkus/ubi-quarkus-mandrel:22.1-java11

ENV MAVEN_HOME=/opt/maven

COPY --from=maven:3-eclipse-temurin-11-alpine /usr/share/maven ${MAVEN_HOME}

ENV PATH="${PATH}:${MAVEN_HOME}/bin"

# RUN ln -s /opt/maven/bin/mvn /usr/bin/mvn

USER 1001

# Clear ENTRYPOINT
ENTRYPOINT ["mvn"]
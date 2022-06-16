FROM andyhan/nodejs-builder:16

COPY --from=maven:3-eclipse-temurin-11-alpine /usr/share/maven /opt/maven
COPY --from=quay.io/quarkus/ubi-quarkus-mandrel:22.1-java11 /opt/mandrel /opt/mandrel

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
ENV JAVA_HOME=/opt/mandrel GRAALVM_HOME=/opt/mandrel
ENV MAVEN_HOME=/opt/maven
ENV PATH="/opt/mandrel:${PATH}"

RUN ln -s /opt/maven/bin/mvn /usr/bin/mvn

# Command prompt
CMD ["mvn"]
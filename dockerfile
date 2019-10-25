FROM alpine:latest AS build-env

WORKDIR /tmp
RUN apk add --no-cache curl && \
    curl -o orion.zip http://mirrors.ibiblio.org/eclipse/orion/drops/R-20.0-201903291844/eclipse-orion-20.0.0S1-linux.gtk.x86_64.zip && \
    unzip orion.zip

RUN curl -L -b "eula_3_1_agreed=tools.hana.ondemand.com/developer-license-3_1.txt" -o webide.zip https://tools.hana.ondemand.com/additional/sap-webide-personal-edition-1.53.9-trial-win32.win32.x86_64.zip && \
    mkdir sap-webide && \
    unzip webide.zip -d sap-webide

FROM openjdk:8-jre-slim

COPY --from=build-env /tmp/eclipse /opt/eclipse

# Copy configuration from webide
COPY --from=build-env /tmp/sap-webide/eclipse/artifacts.xml /opt/eclipse/artifacts.xml
COPY --from=build-env /tmp/sap-webide/eclipse/configuration /opt/eclipse/configuration
COPY --from=build-env /tmp/sap-webide/eclipse/features /opt/eclipse/features
COPY --from=build-env /tmp/sap-webide/eclipse/p2 /opt/eclipse/p2
COPY --from=build-env /tmp/sap-webide/eclipse/plugins /opt/eclipse/plugins

RUN chmod +x /opt/eclipse/orion

WORKDIR /opt/eclipse
EXPOSE 8080
CMD ["/opt/eclipse/orion"]
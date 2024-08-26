FROM eclipse-temurin:11-jre-alpine

ENV FC_LANG=en-US LC_CTYPE=en_US.UTF-8

RUN apk add --no-cache bash ttf-dejavu fontconfig

# Create a non-root user
RUN addgroup -S metabase && adduser -S metabase -G metabase

# Create the plugins directory and set permissions
RUN mkdir -p /plugins && chown -R metabase:metabase /plugins

# Download and install Metabase jar
RUN wget -q https://downloads.metabase.com/v0.50.21/metabase.jar -O /app/metabase.jar && \
    chown metabase:metabase /app/metabase.jar

EXPOSE 3000

USER metabase

CMD ["java", "-jar", "/app/metabase.jar"]
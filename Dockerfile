FROM eclipse-temurin:11-jre-alpine

ENV FC_LANG=en-US LC_CTYPE=en_US.UTF-8

RUN apk add --no-cache bash ttf-dejavu fontconfig

# Create a non-root user
RUN addgroup -S metabase && adduser -S metabase -G metabase

# Create necessary directories and set permissions
RUN mkdir -p /app /plugins && \
    chown -R metabase:metabase /app /plugins

# Download and install Metabase jar
RUN wget -q https://downloads.metabase.com/v0.50.21/metabase.jar -O /app/metabase.jar && \
    chown metabase:metabase /app/metabase.jar

EXPOSE 3000

USER metabase

WORKDIR /app

CMD echo "Starting Metabase..." && \
    echo "Java version:" && java -version && \
    echo "Current user:" && id && \
    echo "Metabase.jar location:" && ls -l /app/metabase.jar && \
    java -jar /app/metabase.jar
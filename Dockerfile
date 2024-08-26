FROM eclipse-temurin:17-jre-alpine

ENV FC_LANG=en-US LC_CTYPE=en_US.UTF-8

RUN apk add --no-cache bash ttf-dejavu fontconfig wget

# Create a non-root user
RUN addgroup -S metabase && adduser -S metabase -G metabase

# Create necessary directories and set permissions
RUN mkdir -p /app /plugins && \
    chown -R metabase:metabase /app /plugins

# Download your custom Metabase JAR from GitHub release
RUN wget -q https://github.com/aritellavsn/waresdata/releases/download/v1.0.0/metabase.jar -O /app/metabase.jar && \
    chown metabase:metabase /app/metabase.jar

EXPOSE 3000

USER metabase

WORKDIR /app

# Add Java options for better container support
ENV JAVA_OPTS="-XX:+IgnoreUnrecognizedVMOptions -XX:+UseContainerSupport -XX:MaxRAMPercentage=75"

CMD ["sh", "-c", "java $JAVA_OPTS -jar /app/metabase.jar"]
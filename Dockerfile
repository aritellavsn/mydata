# Use the official Clojure image as the base image
FROM clojure:tools-deps

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Download and install dependencies
RUN clojure -M:deps

# Run the application
CMD ["clojure", "-M", "-m", "your.main.namespace"]

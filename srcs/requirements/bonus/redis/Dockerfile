# Use Debian Bullseye as the base image
FROM debian:bullseye

# Set the working directory
WORKDIR /data

# Install required dependencies and Redis
RUN apt-get update && apt-get install -y --no-install-recommends redis-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Expose Redis default port
EXPOSE 6379

# Command to run Redis in the foreground
CMD ["redis-server", "--save", "20", "1", "--loglevel", "warning", "--daemonize", "no"]

FROM redis:bullseye

WORKDIR /data

EXPOSE 6379

# Command to run Redis server
CMD ["redis-server", "--save", "20", "1", "--loglevel", "warning"]
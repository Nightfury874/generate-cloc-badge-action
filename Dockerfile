FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    cloc \
    jq

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]

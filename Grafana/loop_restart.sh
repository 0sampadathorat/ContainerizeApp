#!/bin/bash

# Check if the container name was provided
if [ -z "$1" ]; then
  echo "Error: Container name is required."
  echo "Usage: $0 <container_name>"
  exit 1
fi

# Get the container name from the first argument
CONTAINER_NAME="$1"

# Check if the container exists
if ! docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Error: Container '$CONTAINER_NAME' does not exist."
  exit 1
fi

# Maximum number of restarts (optional)
MAX_RESTARTS=100

# Restart loop
count=0
while [ $count -lt $MAX_RESTARTS ]
do
    echo "Restarting container: $CONTAINER_NAME ($count)"
    
    # Stop the container
    docker stop $CONTAINER_NAME
    
    # Start the container again
    docker start $CONTAINER_NAME
    
    # Increment restart count
    count=$((count + 1))

    # Wait for a few seconds before restarting again (adjust as needed)
    sleep 2
done

echo "Finished restarting the container $MAX_RESTARTS times."
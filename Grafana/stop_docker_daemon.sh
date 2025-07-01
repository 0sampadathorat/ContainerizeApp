#!/bin/bash
# Script to stop the Docker daemon

# Check if Docker service exists
if Get-Service -Name docker -ErrorAction SilentlyContinue; then
    Stop-Service docker
    echo "Docker daemon stopped successfully."
else
    echo "Docker service not found. Please ensure Docker is installed and running."
fi

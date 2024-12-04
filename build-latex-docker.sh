#!/bin/bash

# Set the Docker image name
DOCKER_IMAGE="latex-compiler"

# Directory containing the Dockerfile
DOCKER_DIR="./"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed"
    exit 1
fi

# Build the Docker image
echo "Building Docker image..."
docker build -t "$DOCKER_IMAGE" "$DOCKER_DIR"

if [ $? -eq 0 ]; then
    echo "Docker image built successfully!"
    echo "You can now use 'compile-latex.sh' to compile your LaTeX projects."
else
    echo "Error building Docker image"
    exit 1
fi


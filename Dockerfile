# Base image
FROM python:3.11-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Working directory
WORKDIR /app

# Install ChromaDB + optional dependencies
ENV PIP_NO_CACHE_DIR=1
RUN pip install chromadb[server]==0.4.24 sentence-transformers

# Make a directory for persistent DB storage
RUN mkdir -p /app/chroma-data
VOLUME /app/chroma-data

# Set environment variables for auth + telemetry
ENV CHROMA_TELEMETRY_ENABLED=false
ENV CHROMA_SERVER_AUTHN_CREDENTIALS='{
  "auth_method": "token",
  "tenants": {
    "default_tenant": {
      "username": "admin",
      "password": "supersecure123",
      "api_key": "z4mtyftnvtnn3jbo7lrt891cpcnwk7q2"
    }
  }
}'

# Expose default Chroma port
EXPOSE 8000

# Start ChromaDB server with persistent storage + multi-tenant auth
CMD ["chromadb", "run", "--path", "/app/chroma-data", "--host", "0.0.0.0", "--port", "8000"]

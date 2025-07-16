FROM chromadb/chroma:1.0.15

# Optional auth and config
ENV CHROMA_SERVER_AUTHN_CREDENTIALS="{\"auth_method\":\"token\",\"tenants\":{\"default_tenant\":{\"username\":\"admin\",\"password\":\"supersecure123\",\"api_key\":\"z4mtyftnvtnn3jbo7lrt891cpcnwk7q2\"}}}"
ENV CHROMA_TELEMETRY_ENABLED=false

# This will persist vector data at this path (mount volume here in Railway)
VOLUME ["/data"]

# Start server (this is built into the base image)
CMD ["start", "--path", "/data", "--host", "0.0.0.0", "--port", "8000"]

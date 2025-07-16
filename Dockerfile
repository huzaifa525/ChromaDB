FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV PIP_NO_CACHE_DIR=1
RUN pip install chromadb[server]==0.4.24 sentence-transformers

# Disable telemetry
ENV CHROMA_TELEMETRY_ENABLED=false

# Inline auth config as escaped JSON
ENV CHROMA_SERVER_AUTHN_CREDENTIALS="{\"auth_method\":\"token\",\"tenants\":{\"default_tenant\":{\"username\":\"admin\",\"password\":\"supersecure123\",\"api_key\":\"z4mtyftnvtnn3jbo7lrt891cpcnwk7q2\"}}}"

EXPOSE 8000

# ✅ Use Python module directly to run Chroma server
CMD ["python", "-m", "chromadb.cli", "run", "--path", "/app/chroma-data", "--host", "0.0.0.0", "--port", "8000"]

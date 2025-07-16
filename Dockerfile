FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV PIP_NO_CACHE_DIR=1

# ✅ Install stable, NumPy-compatible version
RUN pip install chromadb[server]==1.0.15 sentence-transformers

# ✅ Inline escaped credentials
ENV CHROMA_TELEMETRY_ENABLED=false
ENV CHROMA_SERVER_AUTHN_CREDENTIALS="{\"auth_method\":\"token\",\"tenants\":{\"default_tenant\":{\"username\":\"admin\",\"password\":\"supersecure123\",\"api_key\":\"z4mtyftnvtnn3jbo7lrt891cpcnwk7q2\"}}}"

EXPOSE 8000

# ✅ Correct way to run Chroma (even in v1.0.15)
CMD ["python", "-m", "chromadb.cli", "start", "--path", "/app/chroma-data", "--host", "0.0.0.0", "--port", "8000"]

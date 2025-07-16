# -------------------------------
# 🚀 Base Image
# -------------------------------
FROM python:3.11-slim

# -------------------------------
# 🛠 Install Dependencies
# -------------------------------
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
 && rm -rf /var/lib/apt/lists/*

# -------------------------------
# 📁 Working Directory
# -------------------------------
WORKDIR /app

# -------------------------------
# 🧠 Install ChromaDB + Embeddings
# -------------------------------
ENV PIP_NO_CACHE_DIR=1
RUN pip install chromadb[server]==0.4.24 sentence-transformers

# -------------------------------
# 🔐 Server Auth Config (Inline)
# -------------------------------
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

# -------------------------------
# 🌍 Expose API Port
# -------------------------------
EXPOSE 8000

# -------------------------------
# 🧠 ChromaDB Startup Command
# -------------------------------
# NOTE: /app/chroma-data is your Railway volume mount path
CMD ["chromadb", "run", "--path", "/app/chroma-data", "--host", "0.0.0.0", "--port", "8000"]

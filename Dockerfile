FROM chromadb/chroma:1.0.15

# Disable telemetry (optional but recommended)
ENV CHROMA_TELEMETRY_ENABLED=false

# ✅ Set server auth config inline (escaped JSON)
ENV CHROMA_SERVER_AUTHN_CREDENTIALS={"auth_method":"token","tenants":{"default_tenant":{"username":"admin","password":"supersecure123","api_key":"z4mtyftnvtnn3jbo7lrt891cpcnwk7q2"}}}

# ✅ Default command — start Chroma server using Railway-mounted volume at /data
CMD ["start", "--path", "/data", "--host", "0.0.0.0", "--port", "8000"]

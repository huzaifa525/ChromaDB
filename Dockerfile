FROM ghcr.io/chroma-core/chroma:1.0.15

# ✅ Auth + telemetry config (passed via ENV)
ENV CHROMA_TELEMETRY_ENABLED=false
ENV CHROMA_SERVER_AUTHN_CREDENTIALS={"auth_method":"token","tenants":{"default_tenant":{"username":"admin","password":"supersecure123","api_key":"z4mtyftnvtnn3jbo7lrt891cpcnwk7q2"}}}

# ✅ Run the Chroma server on port 8000
CMD ["run", "--path", "/data", "--host", "0.0.0.0", "--port", "8000"]

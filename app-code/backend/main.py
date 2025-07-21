
import os
from fastapi import FastAPI

app = FastAPI()

REGION = os.getenv("REGION", "unknown-region")

@app.get("/health")
def health():
    return {"status": "healthy"}

@app.get("/api/message")
def message():
    return {
        "message": "Hello from the backend!",
        "region": REGION
    }

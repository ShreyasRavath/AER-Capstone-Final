
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"

def test_message():
    response = client.get("/api/message")
    assert response.status_code == 200
    data = response.json()
    assert "message" in data
    assert "region" in data

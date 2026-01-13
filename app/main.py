from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="Prediction Service", version="1.0.0")


class PredictionResponse(BaseModel):
    score: float


@app.get("/health")
def health_check():
    return {"status": "ok"}


@app.get("/predict", response_model=PredictionResponse)
def predict():
    return {"score": 0.75}


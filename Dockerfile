# -------- Builder stage --------
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# -------- Runtime stage --------
FROM python:3.11-slim
WORKDIR /app

RUN useradd -m appuser
COPY --from=builder /usr/local /usr/local
COPY app /app

USER appuser

HEALTHCHECK CMD curl -f http://localhost:8000/health || exit 1

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]


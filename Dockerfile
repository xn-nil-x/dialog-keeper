# ============================================
# DIALOG KEEPER - Production Dockerfile
# ============================================

FROM python:3.11-slim as base

# Метаданные
LABEL maintainer="Dialog Keeper Team"
LABEL description="Corporate Communications Gateway for Telegram"
LABEL version="0.1.0"

# Переменные окружения
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Рабочая директория
WORKDIR /app

# Системные зависимости
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    curl \
    && rm -rf /var/lib/apt/lists/*

# ============================================
# Builder stage - установка зависимостей
# ============================================
FROM base as builder

COPY requirements.txt .

RUN pip install --user --no-warn-script-location -r requirements.txt

# ============================================
# Runtime stage - финальный образ
# ============================================
FROM base as runtime

# Копируем установленные пакеты
COPY --from=builder /root/.local /root/.local

# Добавляем в PATH
ENV PATH=/root/.local/bin:$PATH

# Создаём непривилегированного пользователя
RUN useradd -m -u 1000 botuser && \
    mkdir -p /app/logs /app/data && \
    chown -R botuser:botuser /app

# Копируем код приложения
COPY --chown=botuser:botuser src/ ./src/
COPY --chown=botuser:botuser config/ ./config/

USER botuser

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD python -c "import sys; sys.exit(0)"

# Запуск
CMD ["python", "src/main.py"]


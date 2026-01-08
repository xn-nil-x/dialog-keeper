.PHONY: help install dev test lint format clean docker-build docker-up docker-down

# ============================================
# DIALOG KEEPER - Makefile
# ============================================

help: ## Показать справку
	@echo "Dialog Keeper - Доступные команды:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

# ============================================
# Development
# ============================================

install: ## Установить зависимости
	pip install -r requirements.txt

dev: ## Установить зависимости для разработки
	pip install -r requirements.txt
	pip install -e .

run: ## Запустить бота локально
	python src/main.py

# ============================================
# Testing
# ============================================

test: ## Запустить тесты
	pytest tests/ -v

test-cov: ## Запустить тесты с покрытием
	pytest tests/ -v --cov=src --cov-report=html --cov-report=term

test-watch: ## Запустить тесты в watch mode
	pytest-watch tests/ -v

# ============================================
# Code Quality
# ============================================

lint: ## Проверить код (ruff, mypy)
	ruff check src/
	mypy src/

format: ## Форматировать код (black, ruff)
	black src/ tests/
	ruff check --fix src/

format-check: ## Проверить форматирование без изменений
	black --check src/ tests/
	ruff check src/

# ============================================
# Docker
# ============================================

docker-build: ## Собрать Docker образ
	docker build -t dialog-keeper:latest .

docker-up: ## Запустить все сервисы
	docker-compose up -d

docker-down: ## Остановить все сервисы
	docker-compose down

docker-logs: ## Показать логи
	docker-compose logs -f bot

docker-restart: ## Перезапустить бота
	docker-compose restart bot

docker-clean: ## Удалить контейнеры и volumes
	docker-compose down -v

# ============================================
# Database
# ============================================

db-migrate: ## Применить миграции БД
	alembic upgrade head

db-rollback: ## Откатить последнюю миграцию
	alembic downgrade -1

db-create-migration: ## Создать новую миграцию (name=название)
	alembic revision --autogenerate -m "$(name)"

db-reset: ## Сбросить БД (ОСТОРОЖНО!)
	alembic downgrade base
	alembic upgrade head

# ============================================
# Cleanup
# ============================================

clean: ## Удалить временные файлы
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type f -name "*.log" -delete
	rm -rf .pytest_cache
	rm -rf .mypy_cache
	rm -rf .ruff_cache
	rm -rf htmlcov
	rm -rf dist
	rm -rf build
	rm -rf *.egg-info

clean-data: ## Удалить данные и логи (ОСТОРОЖНО!)
	rm -rf data/*
	rm -rf logs/*
	rm -rf *.db

# ============================================
# Secrets Management
# ============================================

secrets-setup: ## Создать папку для секретов
	mkdir -p secrets
	chmod 700 secrets
	cp .env.example .env
	@echo "✅ Папка secrets создана. Заполните .env файл!"

secrets-check: ## Проверить наличие необходимых секретов
	@echo "Проверка переменных окружения..."
	@test -f .env || (echo "❌ .env файл не найден!" && exit 1)
	@grep -q "TELEGRAM_BOT_TOKEN" .env || (echo "❌ TELEGRAM_BOT_TOKEN не настроен" && exit 1)
	@grep -q "OPENAI_API_KEY" .env || (echo "❌ OPENAI_API_KEY не настроен" && exit 1)
	@echo "✅ Основные секреты настроены!"

# ============================================
# Monitoring
# ============================================

logs: ## Показать логи бота
	tail -f logs/dialog_keeper.log

logs-error: ## Показать только ошибки
	tail -f logs/dialog_keeper.log | grep ERROR

# ============================================
# Production
# ============================================

deploy: ## Задеплоить на сервер (для настройки)
	@echo "Деплой не настроен. Настройте в Makefile или CI/CD."

backup: ## Создать backup БД
	@echo "Создание backup..."
	docker-compose exec postgres pg_dump -U dialog_keeper dialog_keeper > backup_$(shell date +%Y%m%d_%H%M%S).sql
	@echo "✅ Backup создан!"

# ============================================
# Info
# ============================================

info: ## Показать информацию о проекте
	@echo "Dialog Keeper v0.1.0"
	@echo "Python: $(shell python --version)"
	@echo "Docker: $(shell docker --version)"
	@echo "Docker Compose: $(shell docker-compose --version)"


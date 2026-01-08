# 🧪 Tests

Тесты для Dialog Keeper.

## Структура

```
tests/
├── unit/               # Unit тесты
│   ├── test_bot/
│   ├── test_ai/
│   ├── test_integrations/
│   └── test_database/
├── integration/        # Integration тесты
│   ├── test_bot_ai.py
│   ├── test_kaiten.py
│   └── test_full_flow.py
├── e2e/               # End-to-end тесты
│   └── test_user_flow.py
├── fixtures/          # Тестовые данные
│   ├── messages.py
│   └── responses.py
└── conftest.py        # Pytest конфигурация
```

## Запуск тестов

```bash
# Все тесты
pytest

# С покрытием
pytest --cov=src --cov-report=html

# Только unit тесты
pytest tests/unit/

# Только integration тесты
pytest tests/integration/

# Конкретный модуль
pytest tests/unit/test_bot/test_handlers.py

# Watch mode
pytest-watch
```

## Требования к тестам

- ✅ Покрытие кода >= 80%
- ✅ Все critical paths должны быть покрыты
- ✅ Mock внешние API (Telegram, OpenAI, Kaiten)
- ✅ Используйте fixtures для повторяющихся данных
- ✅ Тесты должны быть быстрыми (< 5 сек)

## TODO

- [ ] Создать unit тесты для bot handlers
- [ ] Создать unit тесты для AI module
- [ ] Создать integration тесты для RAG
- [ ] Создать e2e тесты для user flow
- [ ] Настроить CI/CD для автоматического запуска тестов


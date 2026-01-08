# 💾 Database Module

Модуль для работы с базой данных.

## Структура

```
database/
├── __init__.py
├── models.py               # SQLAlchemy модели
├── session.py              # Управление сессиями
├── repositories/           # Repository pattern
│   ├── __init__.py
│   ├── user_repository.py
│   ├── message_repository.py
│   └── ticket_repository.py
└── migrations/             # Alembic миграции
    └── versions/
```

## Модели данных

### User
- `id` - Telegram user ID
- `username` - Telegram username
- `first_name`, `last_name`
- `is_internal` - внутренний сотрудник?
- `created_at`, `updated_at`

### Chat
- `id` - Telegram chat ID
- `type` - private/group/supergroup
- `title` - название чата
- `is_archived` - архивирован?
- `created_at`

### Message
- `id` - уникальный ID
- `telegram_id` - Telegram message ID
- `chat_id` - ссылка на Chat
- `user_id` - ссылка на User
- `text` - текст сообщения
- `message_type` - text/voice/photo/etc
- `is_noise` - флаг "флуд"
- `intent` - классифицированное намерение
- `created_at`

### Ticket
- `id` - уникальный ID
- `kaiten_id` - ID в Kaiten
- `message_id` - связь с исходным сообщением
- `status` - открыт/закрыт/в работе
- `assigned_to` - кому назначен
- `created_at`, `resolved_at`

### KnowledgeEntry
- `id` - уникальный ID
- `question` - вопрос
- `answer` - ответ
- `source` - источник (kaiten/manual/docs)
- `validated_by` - кто подтвердил
- `embedding_id` - ID в Qdrant
- `created_at`

## TODO

- [ ] Создать SQLAlchemy модели
- [ ] Настроить Alembic миграции
- [ ] Реализовать repositories
- [ ] Добавить индексы для оптимизации
- [ ] Настроить connection pooling


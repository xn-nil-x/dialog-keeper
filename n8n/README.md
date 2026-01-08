# 🔄 n8n Workflows для Dialog Keeper

Эта папка содержит workflow для автоматизации в n8n.

## Структура

```
n8n/
├── workflows/              # Экспортированные workflow (JSON)
│   ├── 01-escalate-kaiten.json
│   ├── 02-sync-knowledge-base.json
│   ├── 03-schedule-meeting.json
│   ├── 04-daily-report.json
│   └── 05-monitoring.json
├── credentials/           # Шаблоны credentials (БЕЗ реальных данных!)
│   └── credentials.example.json
└── README.md             # Этот файл
```

## Как импортировать workflow

### Через UI:
1. Откройте n8n: http://localhost:5678
2. Workflows → Import from File
3. Выберите JSON файл из `workflows/`

### Через API:
```bash
curl -X POST http://localhost:5678/api/v1/workflows/import \
  -H "Content-Type: application/json" \
  -d @workflows/01-escalate-kaiten.json
```

## Список Workflow

### 1. Escalate to Kaiten (`01-escalate-kaiten.json`)
**Назначение:** Создание тикета в Kaiten при эскалации

**Trigger:** Webhook `/webhook/escalate`

**Input:**
```json
{
  "chat_id": "123456",
  "user_id": "789",
  "username": "john_doe",
  "question": "Как настроить OAuth?",
  "ai_answer": "...",
  "escalation_reason": "user_requested_human"
}
```

**Output:**
```json
{
  "success": true,
  "ticket_id": 12345,
  "ticket_url": "https://ripas.kaiten.ru/cards/12345"
}
```

---

### 2. Sync Knowledge Base (`02-sync-knowledge-base.json`)
**Назначение:** Синхронизация закрытых тикетов Kaiten → База знаний

**Trigger:** Schedule (каждые 6 часов: 00:00, 06:00, 12:00, 18:00)

**Что делает:**
1. Получает закрытые тикеты за последние 6 часов
2. Извлекает вопрос и решение
3. Генерирует embeddings (OpenAI)
4. Сохраняет в Qdrant
5. Обновляет метаданные в PostgreSQL
6. Отправляет summary в Telegram

---

### 3. Schedule Meeting (`03-schedule-meeting.json`)
**Назначение:** Планирование встреч через Google Calendar

**Trigger:** Webhook `/webhook/schedule-meeting`

**Input:**
```json
{
  "chat_id": "123456",
  "user": "john_doe",
  "message": "Давайте созвонимся на следующей неделе",
  "participants": ["john@example.com", "manager@ripas.ru"]
}
```

**Что делает:**
1. Извлекает детали встречи (OpenAI)
2. Проверяет free/busy в Google Calendar
3. Предлагает доступные слоты
4. Создаёт событие после подтверждения
5. Отправляет invite участникам

---

### 4. Daily Report (`04-daily-report.json`)
**Назначение:** Ежедневный отчёт для команды

**Trigger:** Schedule (23:00 каждый день)

**Что делает:**
1. Запрашивает статистику за день из PostgreSQL
2. Рассчитывает метрики
3. Генерирует графики (опционально)
4. Отправляет отчёт в Telegram канал команды

---

### 5. Monitoring (`05-monitoring.json`)
**Назначение:** Мониторинг и алерты

**Trigger:** Schedule (каждые 5 минут)

**Что делает:**
1. Проверяет health endpoint бота
2. Проверяет последнее сообщение в БД
3. Проверяет OpenAI API quota
4. Проверяет Qdrant health
5. Отправляет алерты при проблемах

---

## Настройка Credentials

### Требуемые credentials:

1. **Kaiten API**
   - Type: Header Auth
   - Name: `Authorization`
   - Value: `Bearer YOUR_KAITEN_TOKEN`

2. **OpenAI API**
   - Type: Header Auth
   - Name: `Authorization`
   - Value: `Bearer YOUR_OPENAI_KEY`

3. **Google Calendar**
   - Type: OAuth2
   - Следуйте инструкциям n8n для настройки

4. **Telegram Bot**
   - Type: Header Auth (или встроенный Telegram node)
   - Bot Token: `YOUR_BOT_TOKEN`

5. **PostgreSQL**
   - Host: `postgres`
   - Port: `5432`
   - Database: `dialog_keeper`
   - User: `dialog_keeper`
   - Password: `YOUR_PASSWORD`

6. **Qdrant**
   - Host: `http://qdrant:6333`
   - API Key: `YOUR_QDRANT_KEY` (если настроен)

---

## Webhook URLs

После импорта workflow, webhook URLs будут доступны:

- **Escalate:** `http://localhost:5678/webhook/escalate`
- **Schedule Meeting:** `http://localhost:5678/webhook/schedule-meeting`

В production замените `localhost` на ваш домен.

---

## Экспорт workflow

Для backup или версионирования:

1. Workflows → Select workflow → Download
2. Сохраните в `workflows/`
3. Закоммитьте в Git

---

## Безопасность

⚠️ **ВАЖНО:**
- НЕ коммитьте credentials в Git!
- Файлы `credentials/` в `.gitignore`
- Используйте Environment Variables где возможно
- Защитите webhook endpoints токенами

---

## Troubleshooting

### Workflow не запускается
- Проверьте, что workflow активирован (toggle в UI)
- Проверьте credentials
- Посмотрите Execution logs

### Webhook не работает
- Проверьте URL (должен быть доступен из бота)
- Проверьте webhook settings в workflow
- Протестируйте через curl

### Timeout ошибки
- Увеличьте timeout в HTTP Request nodes
- Проверьте доступность внешних сервисов

---

**Документация:** См. `docs/n8n-integration.md`


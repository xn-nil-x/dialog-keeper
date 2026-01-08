# dialog-keeper
Dialog-Keeper (DK) - is a corporate Communications Gateway for Telegram (bot) acting as a single company presence in external chats. It filters noise, archives messages, transcribes voice, and provides AI-generated replies using RAG over support history, documentation, and Kaiten service desk, with built-in human escalation.

## Project Description (EN)

**Communications Gateway** is a corporate Telegram bot designed to act as an official, institutional communication interface between Company's Team and external parties.

The bot represents the company as a single participant in group and private chats with customers, partners, and contractors, replacing personal employee accounts and eliminating ambiguous personal–corporate communication. This approach protects employees from constant interruptions, reduces cognitive overload, and establishes clear professional boundaries.

### Key Capabilities

- **Corporate presence in chats**  
  The bot communicates on behalf of Company, ensuring a consistent, neutral, and non-personal tone.

- **Context-aware filtering and routing**  
  High-volume chat noise is filtered out. Messages containing questions, requests, decisions, or coordination signals are detected and routed internally.

- **Message archiving and institutional memory**  
  All communications are archived, structured, and indexed to provide traceability and long-term context for projects and support cases.

- **Voice message transcription**  
  Incoming and outgoing voice messages are automatically transcribed and linked to the original conversation context.

- **AI knowledge base with RAG**  
  The bot generates fast, clearly labeled AI-based responses using Retrieval-Augmented Generation over:
  - historical support answers from live specialists (continuously enriched),
  - Kaiten service desk cards and resolution history,
  - company documentation and knowledge base articles.

- **Cross-chat knowledge reuse**  
  If similar questions have already been answered in other parallel chats, the bot can reuse this knowledge to ensure consistency and reduce repeated manual support work.

- **Human-in-the-loop escalation**  
  Every AI-generated reply includes an explicit option to request confirmation from a human specialist. This can:
  - create a service desk ticket in Kaiten via API,
  - send an escalation and context digest to a dedicated internal team channel,
  - or notify a responsible team member directly.

### Purpose

The system is built to formalize external communication, prevent implicit or manipulative “informal” requests from becoming unmanaged obligations, and ensure that all interactions are transparent, traceable, and handled at the organizational level rather than through individual employees.

### Design Principles

- **Company-first communication:** the bot speaks on behalf of Company, not individuals.  
- **Asynchronous by default:** requests are processed, triaged, and routed deliberately.  
- **Transparency in AI:** auto-replies are always labeled as AI-generated.  
- **Human-in-the-loop escalation:** one click to route to support with full context.  
- **Knowledge evolves continuously:** every validated human answer enriches the knowledge base.  
- **Scalable integrations:** designed to connect speech-to-text, service desk (Kaiten), calendars, and task trackers.

### Intended Use Cases

- High-traffic customer or contractor group chats  
- Multi-stakeholder project coordination channels  
- Support-heavy communication where responses must be consistent and reusable  
- Long-term archival of agreements, requests, and resolutions  
- Fast first-response automation with controlled human escalation  

---

## Описание проекта (RU)

**Company Communications Gateway** — это корпоративный Telegram-бот, предназначенный для выполнения роли официального институционального интерфейса коммуникаций между Компанией и внешними участниками.

Бот представляет компанию как единого участника в групповых и личных чатах с заказчиками, партнёрами и контрагентами, заменяя персональные аккаунты сотрудников и устраняя размытые границы между личным и корпоративным общением. Такой подход защищает сотрудников от постоянных отвлечений, снижает когнитивную нагрузку и формирует чёткие профессиональные границы.

### Ключевые возможности

- **Корпоративное присутствие в чатах**  
  Бот общается от имени Компании, поддерживая единый, нейтральный и неперсонализированный стиль.

- **Контекстная фильтрация и маршрутизация**  
  Флуд и нерелевантные сообщения отсекаются. Сообщения с вопросами, запросами, договорённостями и координацией выявляются и передаются внутрь компании.

- **Архивация и институциональная память**  
  Вся переписка сохраняется, структурируется и индексируется для обеспечения прослеживаемости и сохранения контекста по проектам и обращениям.

- **Транскрибирование голосовых сообщений**  
  Входящие и исходящие голосовые сообщения автоматически преобразуются в текст и связываются с контекстом диалога.

- **База знаний и AI-ответы (RAG)**  
  Бот формирует быстрые, явно помеченные как AI, ответы на основе Retrieval-Augmented Generation с использованием:
  - истории реальных ответов специалистов техподдержки (динамически пополняемой),
  - карточек и истории решений сервис-деска Kaiten,
  - открытой и внутренней документации компании.

- **Повторное использование знаний между чатами**  
  При наличии аналогичных вопросов в других параллельных чатах бот использует уже сформированные ответы, обеспечивая единообразие и снижая нагрузку на поддержку.

- **Эскалация к живым специалистам**  
  Каждый AI-ответ сопровождается возможностью запросить уточнение у человека. Это может:
  - автоматически создать тикет в сервис-деске Kaiten через API,
  - отправить эскалацию и дайджест контекста в отдельный внутренний чат команды,
  - или направить уведомление конкретному ответственному сотруднику.

### Назначение

Система предназначена для формализации внешних коммуникаций, предотвращения неявных или манипулятивных «неформальных» запросов, а также для обеспечения прозрачности, управляемости и ответственности при работе с обращениями на уровне компании, а не отдельных сотрудников.

### Принципы проектирования

- **Коммуникация от имени компании:** бот говорит от лица Компании, а не отдельных сотрудников.  
- **Асинхронность по умолчанию:** обращения обрабатываются, классифицируются и маршрутизируются осознанно.  
- **Прозрачность AI:** автоответы всегда помечаются как сгенерированные AI.  
- **Эскалация с участием человека:** один клик — и обращение уходит в поддержку с полным контекстом.  
- **Непрерывное развитие знаний:** каждый подтверждённый человеком ответ пополняет базу знаний.  
- **Масштабируемые интеграции:** архитектура рассчитана на связку speech-to-text, сервис-деска (Kaiten), календарей и таск-трекеров.

### Сценарии применения

- Высоконагруженные чаты с заказчиками или подрядчиками  
- Каналы координации проектов с большим числом участников  
- Коммуникации с высокой долей поддержки, где ответы должны быть единообразными и переиспользуемыми  
- Долгосрочное хранение договорённостей, запросов и решений  
- Быстрые первичные ответы с контролируемой эскалацией к живым специалистам  

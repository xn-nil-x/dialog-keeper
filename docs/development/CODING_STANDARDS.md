# 📐 Coding Standards for Dialog Keeper

**Author:** Nil Podozerov  
**Company:** РИПАС (RIPAS)  
**Last Updated:** 2026-01-08  
**Version:** 1.0

---

## Philosophy

> "Code is read much more often than it is written."  
> — Guido van Rossum

Мы пишем код для людей, а не для машин. Код должен быть:
- **Читаемым** — понятен без комментариев
- **Тестируемым** — легко покрыть тестами
- **Поддерживаемым** — легко изменить через год
- **Документированным** — docstrings для всех публичных API

---

## Python Style Guide

### Base Standards

Мы следуем **PEP 8** с некоторыми дополнениями:

- ✅ **PEP 8** — базовый style guide
- ✅ **PEP 257** — docstring conventions
- ✅ **PEP 484** — type hints
- ✅ **Black** — автоформатирование (line length: 100)
- ✅ **Ruff** — быстрый линтер (замена flake8, isort, etc.)
- ✅ **mypy** — статическая типизация

### Line Length

```python
# Maximum line length: 100 characters
MAX_LINE_LENGTH = 100  # Configured in pyproject.toml
```

### Imports

```python
# Порядок импортов (автоматически через Ruff):
# 1. Standard library
import asyncio
import logging
from typing import Optional, Dict, List

# 2. Third-party
from telegram import Update, Message
from telegram.ext import ContextTypes
from langchain.chains import RetrievalQA

# 3. Local/application
from src.ai.rag_engine import RAGEngine
from src.database.models import Message as MessageModel
from src.utils.helpers import format_message

# NO wildcard imports!
# ❌ from telegram import *
# ✅ from telegram import Update, Message
```

### Type Hints

**Обязательно** для всех функций:

```python
# ✅ Good
async def process_message(
    message: str,
    user_id: int,
    context: Optional[Dict[str, Any]] = None
) -> Dict[str, Any]:
    """Process incoming message and generate response.
    
    Args:
        message: User's message text
        user_id: Telegram user ID
        context: Optional conversation context
        
    Returns:
        Dict with 'response' and 'metadata'
        
    Raises:
        ValueError: If message is empty
        APIError: If external API fails
    """
    if not message:
        raise ValueError("Message cannot be empty")
    
    # Implementation
    return {"response": "...", "metadata": {...}}


# ❌ Bad - no type hints
def process_message(message, user_id, context=None):
    # What types? What returns?
    pass
```

### Naming Conventions

```python
# Variables & Functions: snake_case
user_name = "John"
message_count = 42

def calculate_response_time(start: float, end: float) -> float:
    return end - start


# Classes: PascalCase
class MessageProcessor:
    pass

class RAGEngine:
    pass


# Constants: UPPER_SNAKE_CASE
MAX_MESSAGE_LENGTH = 4096
DEFAULT_TIMEOUT = 30
API_BASE_URL = "https://api.example.com"


# Private/Internal: leading underscore
def _internal_helper():
    pass

class _InternalClass:
    pass


# Protected (subclasses): single underscore
class BaseProcessor:
    def _process_data(self):
        pass


# "Private" (name mangling): double underscore
class SecretKeeper:
    def __internal_secret(self):
        pass
```

### Docstrings

**Все публичные функции, классы, модули** должны иметь docstrings:

```python
"""
Module for message classification and intent detection.

This module provides functionality to classify incoming messages
into categories (noise, question, request) and detect user intent.

Author: Nil Podozerov
Company: РИПАС
"""

from typing import Dict, List


class MessageClassifier:
    """Classifies messages using LLM-based approach.
    
    This classifier uses GPT-4 to determine message type and intent.
    It supports multiple languages (Russian, English) and provides
    confidence scores for each classification.
    
    Attributes:
        model_name: OpenAI model to use (default: gpt-4o-mini)
        confidence_threshold: Minimum confidence for classification
        
    Example:
        >>> classifier = MessageClassifier()
        >>> result = await classifier.classify("Как настроить OAuth?")
        >>> print(result['type'])
        'question'
    """
    
    def __init__(
        self,
        model_name: str = "gpt-4o-mini",
        confidence_threshold: float = 0.7
    ) -> None:
        """Initialize classifier.
        
        Args:
            model_name: OpenAI model name
            confidence_threshold: Minimum confidence (0.0-1.0)
            
        Raises:
            ValueError: If confidence_threshold is not in [0, 1]
        """
        if not 0 <= confidence_threshold <= 1:
            raise ValueError("Confidence must be between 0 and 1")
        
        self.model_name = model_name
        self.confidence_threshold = confidence_threshold
    
    async def classify(self, message: str) -> Dict[str, Any]:
        """Classify a message.
        
        Args:
            message: Text message to classify
            
        Returns:
            Dictionary with classification results:
            {
                'type': 'question' | 'noise' | 'request' | 'coordination',
                'intent': Optional intent string,
                'confidence': float (0.0-1.0),
                'metadata': Additional metadata
            }
            
        Raises:
            ValueError: If message is empty
            APIError: If OpenAI API call fails
        """
        # Implementation
        pass
```

### Async/Await

Все IO операции должны быть асинхронными:

```python
# ✅ Good - async IO
async def fetch_data(url: str) -> Dict[str, Any]:
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        return response.json()


# ❌ Bad - blocking IO
def fetch_data(url: str) -> Dict[str, Any]:
    response = requests.get(url)  # Blocks event loop!
    return response.json()


# Use asyncio for concurrent operations
async def process_multiple_messages(messages: List[str]) -> List[Dict]:
    tasks = [process_message(msg) for msg in messages]
    results = await asyncio.gather(*tasks)
    return results
```

### Error Handling

```python
# ✅ Good - specific exceptions, proper logging
async def create_kaiten_ticket(data: Dict) -> int:
    """Create ticket in Kaiten.
    
    Raises:
        ValueError: If required fields are missing
        KaitenAPIError: If API call fails
        NetworkError: If connection fails
    """
    try:
        # Validate input
        if not data.get('title'):
            raise ValueError("Title is required")
        
        # Make API call with timeout
        async with httpx.AsyncClient(timeout=30.0) as client:
            response = await client.post(
                KAITEN_API_URL,
                json=data,
                headers={'Authorization': f'Bearer {KAITEN_TOKEN}'}
            )
            response.raise_for_status()
            
        result = response.json()
        logger.info(f"Created Kaiten ticket: {result['id']}")
        return result['id']
        
    except httpx.TimeoutException as e:
        logger.error(f"Kaiten API timeout: {e}")
        raise NetworkError("Kaiten API timeout") from e
        
    except httpx.HTTPStatusError as e:
        logger.error(f"Kaiten API error {e.response.status_code}: {e}")
        raise KaitenAPIError(f"API returned {e.response.status_code}") from e
        
    except Exception as e:
        logger.exception("Unexpected error creating Kaiten ticket")
        raise


# ❌ Bad - bare except, no logging
def create_ticket(data):
    try:
        # ... code ...
        pass
    except:  # Too broad!
        return None  # Silent failure!
```

### Logging

```python
import structlog

# Use structured logging
logger = structlog.get_logger(__name__)

# ✅ Good - structured, contextual
async def process_message(message: Message) -> None:
    logger.info(
        "Processing message",
        message_id=message.id,
        user_id=message.user_id,
        chat_id=message.chat_id,
        message_type=message.type
    )
    
    try:
        result = await classifier.classify(message.text)
        logger.info(
            "Message classified",
            message_id=message.id,
            classification=result['type'],
            confidence=result['confidence']
        )
    except Exception as e:
        logger.exception(
            "Failed to classify message",
            message_id=message.id,
            error=str(e)
        )
        raise


# Log levels:
logger.debug("Detailed debug info")     # Development only
logger.info("Normal operation")          # Important events
logger.warning("Something unexpected")   # Recoverable issues
logger.error("Operation failed")         # Errors
logger.exception("Uncaught exception")   # Errors with traceback
logger.critical("System failure")        # Critical failures
```

---

## Code Organization

### File Structure

```python
"""
Module docstring at the top.

Author: Nil Podozerov
Company: РИПАС
"""

# 1. Imports (grouped by standard/third-party/local)
import asyncio
from typing import Optional

from telegram import Update
from langchain.chains import RetrievalQA

from src.database.models import Message

# 2. Constants
MAX_RETRIES = 3
DEFAULT_TIMEOUT = 30.0

# 3. Type aliases (if any)
MessageHandler = Callable[[Update, ContextTypes.DEFAULT_TYPE], Awaitable[None]]

# 4. Classes and functions
class MyClass:
    pass

def my_function():
    pass

# 5. Main execution (if applicable)
if __name__ == "__main__":
    asyncio.run(main())
```

### Directory Structure

```
src/
├── __init__.py          # Package initialization
├── main.py              # Entry point
├── bot/                 # Telegram bot module
│   ├── __init__.py
│   ├── telegram_bot.py  # Main bot handler
│   ├── handlers/        # Message handlers
│   │   ├── __init__.py
│   │   ├── commands.py
│   │   └── messages.py
│   └── keyboards.py     # Keyboard layouts
├── ai/                  # AI/RAG module
│   ├── __init__.py
│   ├── llm_provider.py
│   └── rag_engine.py
└── utils/               # Utilities
    ├── __init__.py
    └── helpers.py
```

---

## Testing

### Test Structure

```python
"""
Tests for message classifier.

Author: Nil Podozerov
"""

import pytest
from unittest.mock import AsyncMock, patch

from src.ai.classifier import MessageClassifier


@pytest.fixture
def classifier():
    """Create classifier instance for testing."""
    return MessageClassifier(confidence_threshold=0.7)


@pytest.mark.asyncio
async def test_classify_question(classifier):
    """Test classification of question message."""
    message = "Как настроить OAuth?"
    
    result = await classifier.classify(message)
    
    assert result['type'] == 'question'
    assert result['confidence'] >= 0.7
    assert 'intent' in result


@pytest.mark.asyncio
async def test_classify_empty_message_raises_error(classifier):
    """Test that empty message raises ValueError."""
    with pytest.raises(ValueError, match="Message cannot be empty"):
        await classifier.classify("")


@pytest.mark.asyncio
async def test_classify_with_api_error(classifier):
    """Test handling of API errors."""
    with patch('openai.ChatCompletion.acreate', side_effect=APIError("API down")):
        with pytest.raises(APIError):
            await classifier.classify("test message")
```

### Test Coverage

- **Minimum coverage:** 80%
- **Critical paths:** 100% coverage
- Run tests: `pytest`
- Coverage report: `pytest --cov=src --cov-report=html`

---

## Git Commit Guidelines

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, no logic change)
- `refactor`: Code refactoring
- `test`: Adding/updating tests
- `chore`: Maintenance tasks

**Examples:**

```
feat(bot): add voice transcription support

Implemented Whisper API integration for automatic voice message
transcription. Transcripts are saved to database and sent back
to users.

Closes #42
```

```
fix(rag): handle empty search results gracefully

Previously crashed when Qdrant returned no results. Now returns
a fallback response and logs a warning.

Fixes #67
```

```
docs(readme): update installation instructions

Added Docker Compose setup instructions and troubleshooting section.
```

---

## Code Review Checklist

Before submitting PR, verify:

### Functionality
- [ ] Code works as expected
- [ ] Edge cases handled
- [ ] Error handling implemented
- [ ] No silent failures

### Code Quality
- [ ] Follows PEP 8 and this guide
- [ ] Type hints present
- [ ] Docstrings for public APIs
- [ ] No code duplication
- [ ] No unnecessary complexity

### Testing
- [ ] Tests written and passing
- [ ] Coverage >= 80%
- [ ] Edge cases tested
- [ ] Mock external dependencies

### Documentation
- [ ] README updated (if needed)
- [ ] API docs updated (if needed)
- [ ] Comments for complex logic
- [ ] CHANGELOG updated

### Security
- [ ] No secrets in code
- [ ] Input validation
- [ ] SQL injection prevention
- [ ] XSS prevention (if applicable)

### Performance
- [ ] No N+1 queries
- [ ] Async for IO operations
- [ ] No blocking calls in async code
- [ ] Efficient algorithms

---

## Tools & Automation

### Pre-commit Hooks

```bash
# Install pre-commit
pip install pre-commit
pre-commit install

# Run manually
pre-commit run --all-files
```

### Format Code

```bash
# Auto-format with Black
black src/ tests/

# Sort imports with Ruff
ruff check --fix src/

# Type check with mypy
mypy src/
```

### Run Linters

```bash
# Ruff (fast!)
ruff check src/

# mypy
mypy src/

# All checks
make lint
```

---

## Common Patterns

### Singleton Pattern

```python
class DatabaseConnection:
    _instance: Optional['DatabaseConnection'] = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance
```

### Context Manager

```python
from contextlib import asynccontextmanager

@asynccontextmanager
async def db_transaction():
    """Context manager for database transactions."""
    async with async_session() as session:
        try:
            yield session
            await session.commit()
        except Exception:
            await session.rollback()
            raise
```

### Retry Logic

```python
from tenacity import retry, stop_after_attempt, wait_exponential

@retry(
    stop=stop_after_attempt(3),
    wait=wait_exponential(multiplier=1, min=4, max=10)
)
async def call_external_api(url: str) -> Dict:
    """Call external API with automatic retry."""
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        response.raise_for_status()
        return response.json()
```

---

## Anti-Patterns to Avoid

### ❌ God Objects

```python
# Bad - one class does everything
class DialogKeeper:
    def classify_message(self): pass
    def generate_response(self): pass
    def create_ticket(self): pass
    def send_telegram(self): pass
    def query_database(self): pass
    # ... 50 more methods
```

### ❌ Magic Numbers

```python
# Bad
if confidence > 0.7:
    pass

# Good
CONFIDENCE_THRESHOLD = 0.7
if confidence > CONFIDENCE_THRESHOLD:
    pass
```

### ❌ Mutable Default Arguments

```python
# Bad
def process(items=[]):
    items.append(1)
    return items

# Good
def process(items=None):
    if items is None:
        items = []
    items.append(1)
    return items
```

---

## Questions?

If you have questions about coding standards:

1. Check this document
2. Look at existing code examples
3. Ask in GitHub Discussions
4. Contact: Nil Podozerov

---

**Remember:** Consistency is more important than perfection. When in doubt, follow the existing patterns in the codebase.

**Author:** Nil Podozerov  
**Company:** РИПАС (RIPAS)  
**License:** GPL-3.0  
**Last Updated:** 2026-01-08


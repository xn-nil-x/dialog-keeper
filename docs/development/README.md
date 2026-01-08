# 📐 Development Guidelines

**Project Creator:** Nil Podozerov  
**Company:** РИПАС (RIPAS)

Welcome to the Dialog Keeper development guidelines! This folder contains all the rules and best practices for contributing to the project.

---

## 📚 Documentation Index

### Core Documents

1. **[CODING_STANDARDS.md](./CODING_STANDARDS.md)** - Complete guide to code style, formatting, and best practices
   - Python style guide (PEP 8)
   - Type hints and docstrings
   - Async/await patterns
   - Testing standards
   - Common patterns and anti-patterns

2. **[CONTRIBUTING.md](./CONTRIBUTING.md)** - How to contribute to the project
   - Getting started
   - Development workflow
   - Pull request process
   - Issue reporting

3. **[CODE_REVIEW_GUIDE.md](./CODE_REVIEW_GUIDE.md)** - Guidelines for code reviews
   - For reviewers
   - For authors
   - Review checklist
   - Conflict resolution

---

## 🚀 Quick Start for Contributors

### 1. Setup Development Environment

```bash
# Clone the repository
git clone https://github.com/xn-nil-x/dialog-keeper.git
cd dialog-keeper

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Install pre-commit hooks
pre-commit install

# Setup environment variables
cp .env.example .env
# Edit .env with your credentials

# Run tests
pytest
```

### 2. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
```

### 3. Make Changes

- Follow [CODING_STANDARDS.md](./CODING_STANDARDS.md)
- Write tests
- Update documentation

### 4. Run Quality Checks

```bash
# Format code
black src/ tests/

# Lint
ruff check src/

# Type check
mypy src/

# Run tests
pytest --cov=src

# Or use Makefile
make lint
make test
```

### 5. Submit Pull Request

- Push your branch
- Create PR on GitHub
- Fill in the PR template
- Wait for review

---

## 📏 Code Quality Standards

### Required Tools

- **Black** - Code formatter (line length: 100)
- **Ruff** - Fast linter (replaces flake8, isort, etc.)
- **mypy** - Static type checker
- **pytest** - Testing framework

### Quality Gates

- ✅ **Test coverage:** >= 80%
- ✅ **Type hints:** All functions
- ✅ **Docstrings:** All public APIs
- ✅ **Linting:** Zero warnings
- ✅ **Type checking:** Zero errors

---

## 🧪 Testing

### Test Structure

```
tests/
├── unit/               # Fast, isolated tests
├── integration/        # Tests with external dependencies
└── e2e/               # End-to-end tests
```

### Running Tests

```bash
# All tests
pytest

# With coverage
pytest --cov=src --cov-report=html

# Specific file
pytest tests/unit/test_classifier.py

# Watch mode (requires pytest-watch)
ptw
```

---

## 📝 Commit Message Format

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting
- `refactor`: Code restructuring
- `test`: Tests
- `chore`: Maintenance

**Example:**
```
feat(bot): add voice transcription support

Implemented Whisper API integration for automatic voice message
transcription. Transcripts are saved to database and sent back
to users.

Closes #42
```

---

## 🎨 Code Style Examples

### Good Code

```python
"""Message classifier using LLM.

Author: Nil Podozerov
Company: РИПАС
"""

from typing import Dict, Optional
import structlog

logger = structlog.get_logger(__name__)


class MessageClassifier:
    """Classifies messages using GPT-4.
    
    Example:
        >>> classifier = MessageClassifier()
        >>> result = await classifier.classify("How to setup OAuth?")
        >>> print(result['type'])
        'question'
    """
    
    def __init__(self, model: str = "gpt-4o-mini") -> None:
        """Initialize classifier.
        
        Args:
            model: OpenAI model name
        """
        self.model = model
        logger.info("Classifier initialized", model=model)
    
    async def classify(self, message: str) -> Dict[str, Any]:
        """Classify a message.
        
        Args:
            message: Text to classify
            
        Returns:
            Classification result with type and confidence
            
        Raises:
            ValueError: If message is empty
        """
        if not message:
            raise ValueError("Message cannot be empty")
        
        # Implementation
        logger.debug("Classifying message", length=len(message))
        return {"type": "question", "confidence": 0.95}
```

### Bad Code

```python
# No docstrings, no type hints, poor naming
def c(m):
    if m == "":
        return None
    # Magic numbers
    if len(m) > 100:
        return {"t": "noise"}
    return process(m)  # What does this return?
```

---

## 📦 Project Structure

```
dialog-keeper/
├── src/                    # Source code
│   ├── bot/               # Telegram bot
│   ├── ai/                # AI/RAG module
│   ├── integrations/      # External integrations
│   ├── database/          # Models and DB
│   └── utils/             # Utilities
├── tests/                 # Tests
├── docs/                  # Documentation
│   ├── development/       # This folder
│   ├── architecture/      # Architecture docs
│   └── ...
├── .github/               # GitHub templates
└── ...
```

---

## 🔧 Development Tools

### VS Code Setup

Recommended extensions:
- Python
- Pylance
- Ruff
- Black Formatter
- GitLens

### Settings (`.vscode/settings.json`):
```json
{
  "[python]": {
    "editor.defaultFormatter": "ms-python.black-formatter",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.organizeImports": true
    }
  },
  "python.linting.enabled": true,
  "python.linting.ruffEnabled": true,
  "python.testing.pytestEnabled": true
}
```

---

## 🐛 Debugging

### Local Debugging

```python
# Python debugger
import pdb; pdb.set_trace()

# Or IPython debugger (better)
import ipdb; ipdb.set_trace()
```

### Logging

```python
import structlog

logger = structlog.get_logger(__name__)

# Structured logging
logger.debug("Processing message", message_id=123, user_id=456)
logger.info("Message classified", type="question", confidence=0.95)
logger.error("API call failed", error=str(e), retry_count=3)
```

---

## 📊 CI/CD

### GitHub Actions

All PRs must pass:
- ✅ Linting (Ruff)
- ✅ Type checking (mypy)
- ✅ Tests (pytest)
- ✅ Code coverage (>= 80%)
- ✅ Security scan (Bandit)

### Pre-commit Hooks

Automatically runs on `git commit`:
- Black formatting
- Ruff linting
- Trailing whitespace check
- YAML validation

---

## 🤝 Getting Help

- **Questions:** Open a [Discussion](https://github.com/xn-nil-x/dialog-keeper/discussions)
- **Bugs:** Open an [Issue](https://github.com/xn-nil-x/dialog-keeper/issues)
- **Unclear guidelines:** Ask in PR or Discussion

---

## 📖 Additional Resources

- [Python Official Style Guide (PEP 8)](https://pep8.org/)
- [Type Hints (PEP 484)](https://www.python.org/dev/peps/pep-0484/)
- [Docstring Conventions (PEP 257)](https://www.python.org/dev/peps/pep-0257/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)

---

## 👥 Maintainers

**Project Creator & Lead:**  
**Nil Podozerov**  
Company: РИПАС (RIPAS)

---

**Thank you for contributing to Dialog Keeper!** 🚀

Every contribution, no matter how small, makes this project better.

**License:** GPL-3.0  
**Last Updated:** 2026-01-08


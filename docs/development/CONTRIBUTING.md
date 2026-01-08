# Contributing to Dialog Keeper

**Project Creator:** Nil Podozerov  
**Company:** РИПАС (RIPAS)

First off, thank you for considering contributing to Dialog Keeper! It's people like you that make Dialog Keeper such a great tool.

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Pull Request Process](#pull-request-process)
- [Community](#community)

---

## Code of Conduct

This project and everyone participating in it is governed by the [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

---

## Getting Started

### Prerequisites

- Python 3.11+
- Docker & Docker Compose
- Git
- Basic understanding of Telegram Bot API
- Familiarity with async Python

### Setup Development Environment

1. **Fork the repository**

```bash
# Visit https://github.com/xn-nil-x/dialog-keeper
# Click "Fork" button
```

2. **Clone your fork**

```bash
git clone https://github.com/YOUR_USERNAME/dialog-keeper.git
cd dialog-keeper
```

3. **Add upstream remote**

```bash
git remote add upstream https://github.com/xn-nil-x/dialog-keeper.git
```

4. **Install dependencies**

```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
pip install -r requirements-dev.txt  # Development dependencies

# Install pre-commit hooks
pre-commit install
```

5. **Setup environment variables**

```bash
cp .env.example .env
# Edit .env and fill in your credentials
nano .env
```

6. **Run tests**

```bash
pytest
```

---

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

- **Clear title** and description
- **Steps to reproduce**
- **Expected behavior**
- **Actual behavior**
- **Screenshots** (if applicable)
- **Environment details** (OS, Python version, etc.)

Use the [Bug Report Template](.github/ISSUE_TEMPLATE/bug_report.md).

### Suggesting Features

Feature suggestions are welcome! Please provide:

- **Clear use case**
- **Expected behavior**
- **Possible implementation** (if you have ideas)
- **Alternatives considered**

Use the [Feature Request Template](.github/ISSUE_TEMPLATE/feature_request.md).

### Your First Code Contribution

Unsure where to start? Look for issues labeled:
- `good first issue` - easier issues for beginners
- `help wanted` - issues we need help with
- `documentation` - documentation improvements

---

## Development Workflow

### 1. Create a Branch

```bash
# Update your fork
git checkout main
git pull upstream main

# Create feature branch
git checkout -b feature/your-feature-name
# or
git checkout -b fix/bug-description
```

### 2. Make Changes

- Follow [Coding Standards](CODING_STANDARDS.md)
- Write tests for new functionality
- Update documentation as needed
- Keep commits atomic and focused

### 3. Test Your Changes

```bash
# Run tests
pytest

# Run with coverage
pytest --cov=src --cov-report=html

# Run linters
ruff check src/
mypy src/
black --check src/

# Or use Makefile
make test
make lint
```

### 4. Commit Your Changes

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```bash
git add .
git commit -m "feat(bot): add voice transcription support"
```

**Commit message format:**
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
- `test`: Adding tests
- `chore`: Maintenance

### 5. Push to Your Fork

```bash
git push origin feature/your-feature-name
```

### 6. Create Pull Request

- Go to your fork on GitHub
- Click "Pull Request"
- Fill in the PR template
- Link related issues

---

## Coding Standards

### Must Follow

1. **PEP 8** - Python style guide
2. **Type hints** - All functions must have type annotations
3. **Docstrings** - All public APIs must be documented
4. **Tests** - New code must have tests (80%+ coverage)
5. **Black** - Code must be formatted with Black
6. **Ruff** - Code must pass Ruff linting
7. **mypy** - Code must pass type checking

See [CODING_STANDARDS.md](CODING_STANDARDS.md) for details.

### File Headers

All new Python files should include:

```python
"""
Brief description of the module.

Author: Your Name (or Nil Podozerov for core modules)
Company: РИПАС
License: GPL-3.0
"""
```

---

## Pull Request Process

### Before Submitting

- [ ] Code follows [CODING_STANDARDS.md](CODING_STANDARDS.md)
- [ ] Tests pass locally (`pytest`)
- [ ] Linters pass (`make lint`)
- [ ] Documentation updated (if needed)
- [ ] CHANGELOG.md updated (if user-facing change)
- [ ] Commits are atomic and well-described
- [ ] Branch is up to date with `main`

### PR Template

Your PR should include:

1. **Description** - What does this PR do?
2. **Motivation** - Why is this change needed?
3. **Changes** - List of changes made
4. **Testing** - How was this tested?
5. **Screenshots** - If UI changes
6. **Related Issues** - Links to issues (Closes #123)

### Review Process

1. Maintainers will review your PR
2. CI/CD checks must pass
3. At least one approval required
4. Changes may be requested
5. Once approved, maintainer will merge

### After Merge

- Your contribution will be in the next release
- You'll be added to [AUTHORS.md](../../AUTHORS.md)
- Thank you! 🎉

---

## Development Tips

### Running Locally

```bash
# Start all services
docker-compose up -d

# Watch logs
docker-compose logs -f bot

# Run bot locally (without Docker)
python src/main.py
```

### Debugging

```python
# Use Python debugger
import pdb; pdb.set_trace()

# Or IPython debugger
import ipdb; ipdb.set_trace()

# Structured logging
logger.debug("Debug info", variable=value)
```

### Testing

```bash
# Run specific test
pytest tests/unit/test_classifier.py::test_classify_question

# Run with verbose output
pytest -v

# Run with coverage
pytest --cov=src --cov-report=term-missing

# Run only failed tests
pytest --lf
```

### Documentation

```bash
# Build docs locally (if using Sphinx)
cd docs/
make html

# View in browser
open _build/html/index.html
```

---

## Community

### Communication Channels

- **GitHub Issues** - Bug reports, feature requests
- **GitHub Discussions** - Questions, ideas, general discussion
- **Pull Requests** - Code contributions

### Getting Help

- Read the [documentation](../README.md)
- Search [existing issues](https://github.com/xn-nil-x/dialog-keeper/issues)
- Ask in [GitHub Discussions](https://github.com/xn-nil-x/dialog-keeper/discussions)

### Recognition

Contributors are recognized in:
- [AUTHORS.md](../../AUTHORS.md)
- Release notes
- GitHub contributors graph

---

## License

By contributing, you agree that your contributions will be licensed under the GPL-3.0 License.

---

## Questions?

If you have any questions, feel free to:
- Open an issue
- Start a discussion
- Contact the maintainer: Nil Podozerov

---

**Thank you for contributing to Dialog Keeper!** 🚀

**Project Creator:** Nil Podozerov  
**Company:** РИПАС (RIPAS)  
**License:** GPL-3.0


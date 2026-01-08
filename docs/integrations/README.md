# 🔌 API Integrations Documentation

This folder contains interface descriptions for external systems and modules that Dialog Keeper interacts with.

## 📋 Purpose

This directory serves as a centralized repository for:
- API specifications (Swagger/OpenAPI)
- Interface descriptions in JSON format
- Technical documentation for external system integrations
- Contract definitions for third-party services

## 📁 Folder Structure

```
docs/integrations/
├── README.md (this file)
├── [system-name]/
│   ├── api-spec.json          # Swagger/OpenAPI specification
│   ├── interface.md           # Human-readable interface description
│   ├── examples/              # Request/response examples
│   │   ├── request.json
│   │   └── response.json
│   └── notes.md              # Integration notes, quirks, limitations
```

## 📝 How to Add New Integration Documentation

### 1. Create a System Folder

Create a folder named after the system or service (use lowercase with hyphens):

```bash
mkdir -p docs/integrations/[system-name]
```

### 2. Add API Specification

Place the Swagger/OpenAPI JSON file:
- **File name**: `api-spec.json` or `openapi.json`
- **Format**: JSON (OpenAPI 3.0+ or Swagger 2.0)

### 3. Create Interface Description

Create `interface.md` with:
- Overview of the API
- Authentication methods
- Available endpoints
- Data models
- Rate limits and constraints

### 4. Add Examples (Optional)

Create an `examples/` folder with sample requests and responses

### 5. Document Special Notes

Create `notes.md` for:
- Known issues or quirks
- Workarounds
- Version-specific behavior
- Security considerations

## 🎯 Usage

### For Developers

When integrating with an external system:

1. **Check this folder first** - See if interface documentation already exists
2. **Review the API spec** - Understand available endpoints and data structures
3. **Read the notes** - Learn about known issues and best practices
4. **Use examples** - Reference sample requests/responses for implementation

### For Documentation

When documenting a new integration:

1. Export the API specification (Swagger/OpenAPI)
2. Create a human-readable interface description
3. Add practical examples
4. Document any special considerations

## 📚 Integration Categories

Organize integrations by type:

- **messaging/** - Telegram, Slack, Discord APIs
- **ai/** - OpenAI, Claude, other AI service APIs
- **workflow/** - n8n, automation platform APIs
- **database/** - External database APIs
- **analytics/** - Monitoring and analytics service APIs
- **auth/** - Authentication provider APIs

## 🔍 Example Integration Entry

### Example: OpenAI API

```
docs/integrations/openai/
├── api-spec.json              # OpenAI API specification
├── interface.md               # Overview, endpoints, models
├── examples/
│   ├── chat-completion.json   # Chat API example
│   └── embeddings.json        # Embeddings API example
└── notes.md                   # Rate limits, best practices
```

## ✅ Best Practices

1. **Keep specifications up to date** - Update when APIs change
2. **Version specifications** - Note API version in filenames if needed
3. **Include timestamps** - Document when the spec was last updated
4. **Link to official docs** - Always reference official documentation
5. **Document authentication** - Clearly specify auth requirements
6. **Note environment differences** - Highlight staging vs production differences

## 🔗 Related Documentation

- [n8n Integration Guide](../../n8n/README.md)
- [Development Guide](../development/README.md)
- [Architecture Overview](../architecture/overview.md)
- [Main Project README](../../README.md)

## 📞 Contact

If you have questions about API integrations or need to add new documentation, please refer to the [Contributing Guide](../development/CONTRIBUTING.md).

---

**Last Updated**: January 2026


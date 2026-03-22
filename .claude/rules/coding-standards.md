---
description: General coding standards, style rules, and behavior guidelines for all agents working in this repo.
---

# Coding Standards

## General Rules

1. Read existing code before making any changes.
2. Make the minimum necessary changes. Do not refactor or clean up code outside the scope of the task.
3. Do not introduce breaking changes unless explicitly requested.
4. Follow the Golang Clean Architecture pattern used throughout this project.
5. Never hardcode environment variables or secret values — use `.env` and `config.json`.
6. Add comments to explain non-obvious logic (e.g., after creating a function with complex behavior).
7. Do not use emoji or emoticons in code, comments, or markdown output.
8. Keep chat responses concise; avoid generating markdown summaries unless explicitly requested.
9. Prefer simple, maintainable solutions over clever ones.

## Tech Stack

- **Framework:** Go Fiber (HTTP + WebSocket)
- **ORM:** GORM with MySQL 8.0
- **Cache:** Redis (JWT blacklist storage)
- **Auth:** JWT
- **Real-time:** Fiber WebSocket (hub-based, room-scoped)
- **Conference:** Pion WebRTC SFU (`internal/sfu/`)

## Environment Setup

Copy `.env.example` to `.env` and fill in values. Required variables:
- `DATABASE_USERNAME`, `DATABASE_PASSWORD`, `DATABASE_HOST`, `DATABASE_PORT`, `DATABASE_NAME`
- `JWT_SECRET`
- `REDIS_HOST`, `REDIS_PORT`, `REDIS_DB`

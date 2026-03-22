# CLAUDE.md

Interactive QnA backend. Core differentiator: **XP Ranking gamification system** — rewards quality participation, making the platform usable as a formative assessment tool.

## Commands

```bash
go run cmd/web/main.go                                      # Run server
go test ./tests/...                                         # Run all tests
go test ./tests/user_usecase_test.go ./tests/mocks/*.go -v  # Single test file
go test ./tests/... -run TestFunctionName -v                # Single test function
go build -o bin/server cmd/web/main.go                      # Build
go mod tidy

# Run migrations (adjust DSN to match .env values)
migrate -database "mysql://user:pass@tcp(host:port)/dbname" -path db/migrations up
migrate -database "mysql://user:pass@tcp(host:port)/dbname" -path db/migrations down
```

## Environment

Copy `.env.example` to `.env`. Required: `DATABASE_USERNAME`, `DATABASE_PASSWORD`, `DATABASE_HOST`, `DATABASE_PORT`, `DATABASE_NAME`, `JWT_SECRET`, `REDIS_HOST`, `REDIS_PORT`, `REDIS_DB`

## Tech Stack

Go Fiber (HTTP + WebSocket) · GORM + MySQL 8.0 · Redis (JWT blacklist) · JWT auth · Pion WebRTC SFU (`internal/sfu/`)

## Rules

Load only the files relevant to your task:

| Rule file | When to load |
|-----------|--------------|
| [coding-standards.md](.claude/rules/coding-standards.md) | Always |
| [architecture.md](.claude/rules/architecture.md) | Adding/modifying any domain, controller, use case, or repository |
| [auth.md](.claude/rules/auth.md) | Auth, JWT, middleware, login/logout |
| [database.md](.claude/rules/database.md) | Schema changes, migrations, GORM queries |
| [websocket.md](.claude/rules/websocket.md) | WebSocket events, hub, broadcasting, WebRTC/conference |
| [xp-gamification.md](.claude/rules/xp-gamification.md) | XP awards, leaderboard, timeline |
| [domain-rules.md](.claude/rules/domain-rules.md) | Rooms, participants, questions, polls |
| [testing.md](.claude/rules/testing.md) | Writing or running tests |

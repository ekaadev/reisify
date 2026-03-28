.PHONY: run build tidy clean \
        test-unit test-integration test \
        migrate-up migrate-down

# ── App ──────────────────────────────────────────────────────────────────────

run:
	go run cmd/web/main.go

build:
	CGO_ENABLED=0 go build -o bin/server cmd/web/main.go

tidy:
	go mod tidy

clean:
	rm -rf bin/

# ── Tests ─────────────────────────────────────────────────────────────────────

test-unit:
	go test ./test/unit/... -v

# Requires: docker compose -f docker-compose.test.yml up -d
test-integration:
	go test ./test/integration/... -v

test: test-unit test-integration

# ── Migrations ───────────────────────────────────────────────────────────────
# Usage: DATABASE_URL="postgres://user:pass@localhost:5432/reisify?sslmode=disable" make migrate-up

migrate-up:
	migrate -database "$(DATABASE_URL)" -path db/migrations up

migrate-down:
	migrate -database "$(DATABASE_URL)" -path db/migrations down

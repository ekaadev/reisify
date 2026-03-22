---
description: Test file location, mock patterns, use case instantiation, and how to run tests.
---

# Testing Rules

## Location

Tests are in `tests/` (not colocated with source).

## Tooling

- `go-sqlmock` to mock the GORM DB connection.
- `testify/mock` with hand-written mocks in `tests/mocks/`.

## Writing Tests

- Instantiate use case structs directly in tests using exported fields — do not use constructors.
- New mocks must implement the full interface that the use case depends on.

## Running Tests

```bash
# Run all tests
go test ./tests/...

# Run a single test file (must include mocks)
go test ./tests/user_usecase_test.go ./tests/mocks/*.go -v

# Run a single test function
go test ./tests/... -run TestFunctionName -v
```

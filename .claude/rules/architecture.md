---
description: Clean Architecture layer responsibilities, dependency direction, DI wiring, and new domain scaffolding steps.
---

# Architecture Rules

## Layer Responsibilities

- **Delivery** (`internal/delivery/`) — HTTP controllers and WebSocket handler only. No business logic here.
- **Use Case** (`internal/usecase/`) — All business logic. One file per domain.
- **Repository** (`internal/repository/`) — Data access only via GORM. No business logic.
- **Entity** (`internal/entity/`) — Domain structs only. No methods with business logic.

## Dependency Direction

Controllers depend on use cases. Use cases depend on repositories. Repositories depend on GORM. Never reverse this.

## DI Root

All dependencies are wired in `internal/config/app.go` (`Bootstrap` function). When adding a new domain, register everything here.

## Adding a New Domain (follow this order)

1. `internal/entity/` — entity struct
2. `internal/repository/` — repo embedding `Repository[YourEntity]`
3. `internal/usecase/` — use case with DB, Log, Validate, and repo deps
4. `internal/delivery/http/` — controller
5. `internal/model/` — request/response DTOs
6. `internal/model/converter/` — conversion functions
7. `internal/config/app.go` — wire into `Bootstrap()`
8. `internal/delivery/http/route/route.go` — register routes

## HTTP Response Format

Always use `model.WebResponse`:
```go
// Success
c.JSON(model.WebResponse{Data: response})
// Error
c.Status(fiber.StatusBadRequest).JSON(model.WebResponse{Error: "message"})
// Paginated
c.JSON(model.WebResponse{Data: items, Paging: &model.PaginationResponse{...}})
```

## Key File Locations

| Concern | File |
|---------|------|
| DI root | `internal/config/app.go` |
| Route registration | `internal/delivery/http/route/route.go` |
| Auth middleware | `internal/delivery/http/middleware/auth_middleware.go` |
| Base repository | `internal/repository/repository.go` |
| Common response model | `internal/model/common.go` |
| JWT claims model | `internal/model/auth.go` |

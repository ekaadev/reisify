---
description: JWT authentication, token claims, route protection, Redis blacklisting, and anonymous user handling.
---

# Auth Rules

## Route Protection

- All routes after `c.App.Use(c.AuthMiddleware)` in `route.go` require a Bearer token.
- Get auth claims via `middleware.GetUser(c)` — returns `*model.Auth`.

## Token Claims

- Base token: `UserID`, `Username`.
- Room-scoped token (issued on `Join` and `Create Room`): additionally includes `RoomID`, `ParticipantID`, `IsRoomOwner`.
- WebSocket connections authenticate via `?token=` query param; token must be room-scoped.

## Token Lifecycle

- Logout must blacklist the token in Redis — not just discard it client-side.
- Redis is the source of truth for invalidated tokens.

## Users & Passwords

- Passwords must be hashed with bcrypt before storing.
- Email and username must be validated for uniqueness before insert.

## Anonymous Users

- Anonymous users get a participant record but no `users` row.
- Their JWT has `IsAnonymous: true`.

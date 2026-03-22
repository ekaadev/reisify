---
description: XP award rules, transaction recording, leaderboard, and the full XP table by action.
---

# XP / Gamification Rules

## Core Principle

The XP ranking system is the platform's key differentiator — it identifies and rewards quality participation, making the platform usable as a formative assessment tool.

## XP Mutation Rules

- All XP changes must go through `XPTransactionRepository.AddXP` — never update `xp_score` directly.
- Every XP grant must create an `xp_transaction` record with the correct `source_type` and `source_id`.
- XP is room-scoped. A participant's score is per-room.
- `XPScore` on the `participants` table is a denormalized field updated by `AddXP`, never manually.

## XP Table by Action

| Action | XP | Recipient | Source Type |
|--------|----|-----------|-------------|
| Submit question | +10 | Author | `question_created` |
| Receive upvote | +3 | Question author | `upvote_received` |
| Upvote removed | -3 | Question author | `upvote_received` |
| Presenter validates question | +25 | Question author | `presenter_validated` |
| Vote on poll | +5 | Voter | `poll` |
| Send message | +1 | Sender | `message_created` |

## Leaderboard

- `GET /api/v1/rooms/:room_id/leaderboard` — returns top 10 participants by XP.
- Caller's rank is computed separately via a count query.
- After every XP-awarding action, broadcast `leaderboard:updated` via `broadcastLeaderboardUpdate(hub, roomID)`.

## Timeline

- `GET /api/v1/rooms/:room_id/timeline` — read-only aggregate view.
- Uses a UNION ALL query across `messages`, `questions`, and `polls`.
- Do not add new content types without updating the UNION.
- Cursor pagination uses RFC3339 timestamps (`before`/`after`). Do not mix with page-based pagination.
- Never modify data through the timeline endpoint.

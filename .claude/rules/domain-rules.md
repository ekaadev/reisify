---
description: Business logic rules for each domain: rooms, participants, Q&A questions, and polling.
---

# Domain Rules

## Rooms

- Room codes are generated with `crypto/rand` (cryptographically secure) — do not use `math/rand`.
- Presenter is always auto-enrolled as a participant on room creation (inside the same transaction).
- Only the room presenter can close, delete, or send announcements.
- A room must be `closed` before it can be deleted.
- Room status is one-way: `active` → `closed`. No re-opening.

## Participants

- `Join` is idempotent: if the user already has a participant record in this room, return the existing one.
- `IsRoomOwner` is determined by comparing `participant.UserID` with `room.PresenterID`.
- `XPScore` is a denormalized field on `participants` — updated via `XPTransactionRepository.AddXP`, never manually.
- Leaderboard returns top 10; caller rank is computed separately via a count query.

## Q&A (Questions)

- A participant cannot upvote their own question.
- Duplicate votes are prevented at both application level and DB unique constraint.
- Upvote removal must also reverse the XP grant (negative XP transaction).
- A question can only be validated once (`IsValidatedByPresenter` is a one-way flag).
- `upvote_count` is managed by DB triggers — do NOT manually update it in application code.
- Only the room presenter can call the validate endpoint.

## Polling

- Only the room presenter can create or close polls.
- A participant can only vote once per poll (DB unique constraint + application check).
- Validate that the chosen option actually belongs to the poll before recording the vote.
- `vote_count` on poll options is managed by DB triggers — do NOT manually update it.
- Poll status is one-way: `active` → `closed`. No re-opening.

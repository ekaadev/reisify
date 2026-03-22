---
description: WebSocket hub, event routing, broadcast patterns, and conference/WebRTC SFU rules.
---

# WebSocket Rules

## Connection

- Endpoint: `GET /ws?token={jwt_token}`
- Token must be room-scoped (contains `RoomID` and `ParticipantID`).
- The `Hub` manages room-scoped connections: `internal/delivery/websocket/hub.go`.

## Event Routing

- Incoming events are routed by `EventHandler.HandleMessage` based on the `event` field in the JSON message.
- All event type constants are defined in `internal/delivery/websocket/message.go`.

## Broadcasting

- All room broadcasts use `hub.BroadcastToRoom(roomID, message)`.
- Controllers that need to broadcast must receive `*hub.Hub` as a dependency.
- Never call hub methods directly from use cases — only from controllers/event handlers.

## Leaderboard Broadcast

After every XP-awarding action, call `broadcastLeaderboardUpdate(hub, roomID)` to push the updated leaderboard to the room.

## Known Event Vocabulary (Client → Server)

| Category | Events |
|----------|--------|
| Chat | `message:send`, `chat:typing` |
| Q&A | `question:submit`, `question:upvote`, `question:remove_upvote` |
| Polls | `poll:vote` |
| Leaderboard | `leaderboard:request` |
| WebRTC signaling | `webrtc:offer`, `webrtc:answer`, `webrtc:candidate` |
| Conference control | `conference:start`, `conference:stop`, `conference:join`, `conference:leave`, `conference:raise_hand`, `conference:lower_hand`, `conference:promote`, `conference:demote` |

## Conference / WebRTC SFU

- The `internal/sfu/` package is a Pion-based Selective Forwarding Unit.
- It is wired into the WebSocket `EventHandler` but independent of the HTTP/domain flow.
- Conference control actions (`start`, `stop`, `promote`, `demote`) are restricted to `client.isRoomOwner`.
- Conference state is in-memory only — it is not persisted to the database.

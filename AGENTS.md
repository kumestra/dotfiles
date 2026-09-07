## Confirmation requests

When a user message ends with `#r`, this request requires confirmation.

1. Restate the request and wait for confirmation.
2. After confirmation, perform only the confirmed scope.

This rule applies only to that request. Read-only inspection is always allowed.
Temporary work in `/tmp` is allowed only when it does not modify the project,
global environment, global configuration, or system state.

## Browser-use

1. First check for and reuse an existing browser-use daemon. Start a new daemon
   only when none exists.
2. Keep at most five browser tabs open at once.
3. Never close every tab. Keep at least one tab open so Chrome remains running.
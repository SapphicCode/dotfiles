---
name: go-docs
description: Look up Go package and symbol documentation
compatibility: opencode
---

## What I do

When working with Go code, always prefer these methods for looking up documentation — in priority order:

1. **`go doc`** — fastest, works offline, respects local module versions:
   ```
   go doc <pkg>              # package overview
   go doc <pkg>.<Symbol>     # specific type, func, method
   go doc -all <pkg>         # full package docs
   ```
   Examples:
   ```
   go doc fmt
   go doc fmt.Errorf
   go doc net/http.Client
   go doc -all encoding/json
   ```

2. **WebFetch from pkg.go.dev** — useful when `go doc` is unavailable or for third-party packages not yet downloaded:
   ```
   https://pkg.go.dev/<import-path>
   ```
   Example: `https://pkg.go.dev/sigs.k8s.io/controller-runtime`

## Rules

- Never guess or recall API signatures from memory — always verify with `go doc` or pkg.go.dev
- If behavior is ambiguous from docs alone, read the source directly

## When to use me

- Looking up a Go standard library or third-party package API
- Unsure of a function signature, type definition, or method set
- Discovering what's available in a package before writing code

# A-Team plugin for Claude Code

Build and drive A-Team solutions from Claude Code. The plugin prompts for your
tenant API key when you enable it, connects the generic A-Team MCP, and ships a
`/ateam` skill that walks a new user from zero to a first solution.

## Install

```bash
# add the marketplace (GitHub owner/repo of this repo)
/plugin marketplace add ateam-ai/claude-plugin

# install the plugin — you'll be prompted for your API key
/plugin install ateam@ateam-ai
```

Get your key at https://mcp.ateam-ai.com/get-api-key (format `adas_<tenant>_<hex>`).

## Use

Type `/ateam` (or just mention A-Team). The skill:

1. Confirms the session is authenticated.
2. Lists your solutions — empty means new user.
3. Guides a build using the platform's **live** workflows, spec, and examples.

## What's where

| Piece | File | Role |
| :-- | :-- | :-- |
| Tenant key prompt | `.claude-plugin/plugin.json` (`userConfig`) | Prompts + stores the key securely at enable time |
| MCP connection | `.mcp.json` | Generic A-Team HTTP server; key injected as `Authorization` header |
| Onboarding logic | `skills/ateam/SKILL.md` | `/ateam` entry point + auto-trigger; orchestration only |
| Nudge | `hooks/hooks.json` + `scripts/check-auth.sh` | Reminds the user if enabled without a key |

Design principle: **volatile content stays server-side** (spec, workflows,
examples, all live via MCP tools); **stable orchestration and discovery live in
the plugin** (the skill, the command entry, the key prompt).

## Server-side requirement for one-step auth

`.mcp.json` sends the tenant key as `Authorization: Bearer <key>` at connect
time. For onboarding to be fully seamless (no `ateam_auth` call, no pasting the
key into chat), the A-Team MCP server must authenticate the session from that
header. Until that's wired, the `/ateam` skill falls back to calling
`ateam_auth` with the key. Confirm the exact endpoint path (e.g. `/mcp`) and
header handling before publishing.

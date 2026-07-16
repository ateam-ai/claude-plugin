---
name: ateam
description: Set up and build A-Team solutions. Use when the user wants to start with A-Team, mentions the A-Team platform, has no solution yet, or types /ateam. Orients the user and builds via the live A-Team tools.
argument-hint: "[what you want to build]"
user_invocable: true
---

# A-Team: start here

You orchestrate; the ateam MCP tools are the source of truth. Never describe
A-Team's spec, workflows, or examples from memory — fetch the live versions
from the tools when you need them.

## 1 — Confirm you're connected
The tenant key is supplied to the ateam server at enable time, so the session
is normally already authenticated. Make one read call (`ateam_list_solutions`).
If it returns an auth error, the key wasn't accepted: tell the user to run
`/plugin`, enable "A-Team", and paste their key from
https://mcp.ateam-ai.com/get-api-key — then, as a fallback, call `ateam_auth`
with that api_key.

## 2 — Orient
From `ateam_list_solutions`:
- Empty → new user. Go to step 3.
- Non-empty → summarize the solutions and ask what they want to do. Call
  `ateam_get_solution` before making any claim about a specific one.

## 3 — Build (fetch guidance, don't invent it)
1. `ateam_get_workflows` — the current step-by-step build state machine.
2. `ateam_get_spec` / `ateam_get_examples` — schema + passing examples.
3. Scaffold with `ateam_create_connector` / `ateam_create_plugin` as directed.
4. Deploy + test: `ateam_build_and_run` → `ateam_test_skill`
   (poll `ateam_test_status`).

If $ARGUMENTS is set, treat it as the build target and go straight to step 3.

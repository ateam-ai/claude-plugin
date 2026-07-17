---
name: ateam
description: Set up and build A-Team solutions. Use when the user wants to start with A-Team, mentions the A-Team platform, has no solution yet, or types /ateam. Orients the user and builds via the live A-Team tools.
argument-hint: "[what you want to build]"
user_invocable: true
---

# A-Team: start here

You orchestrate; the ateam MCP tools are the source of truth. Never describe
A-Team's spec, workflows, or examples from memory — fetch the live versions.

## 0 — Load the contract (do this first)
Call `ateam_bootstrap` and **follow its `assistant_behavior_contract`** — it is
the source of truth for how to behave, kept server-side so every client stays in
sync. In particular obey:
- **`conversation_style`** — the user is usually a *business user*, not a
  developer. Plain language (no jargon), scannable bullets + choices, one
  question at a time, grounded in their real solution/skill names.
- **`environment_transparency`** — state the tenant + environment on connect,
  and where anything lands after each deploy (with a link).
- **`build_flow`** — drive builds through `thinking_order` + `minimal_authoring`;
  a requested UI/widget is part of the build (don't defer it silently); pick the
  write path by the tenant's GitHub state.

Everything below is just the tool sequence — the *how you talk and what you
deliver* rules live in the bootstrap contract.

## 1 — Confirm you're connected
The tenant key is supplied at enable time, so the session is normally already
authenticated. Make one read call (`ateam_list_solutions`). On an auth error,
guide the user to re-enable the plugin with their key from
https://mcp.ateam-ai.com/get-api-key (fallback: `ateam_auth`).

## 2 — Orient
- Empty → new user; go to step 3.
- Non-empty → open with a **grounded** summary (solution name + a few skill
  names via `ateam_show_solution_minimal`) and ask what they want to do.

## 3 — Build (fetch guidance, don't invent it)
1. `ateam_get_workflows` — the current build state machine.
2. `ateam_get_spec` / `ateam_get_examples` — schema + passing examples.
3. Author the skill (persona + connectors); scaffold UI with
   `ateam_create_plugin` when a screen is requested.
4. Deploy + test: `ateam_patch` / `ateam_build_and_run` → `ateam_test_skill`.

If $ARGUMENTS is set, treat it as the build target and go to step 3.

# A-Team for Claude Code

Build and deploy [A-Team](https://ateam-ai.com) solutions directly from Claude Code.
Install the plugin, paste your tenant key once, and drive the platform's live
workflows through the `/ateam` skill.

## Install

```
/plugin marketplace add ateam-ai/claude-plugin
/plugin install ateam@ateam-ai
```

You'll be prompted for your **A-Team API key** at install — get one at
https://mcp.ateam-ai.com/get-api-key (format `adas_<tenant>_<hex>`).

## Use

Type `/ateam` (or just mention A-Team). The skill confirms you're connected,
lists your solutions, and guides a build using the platform's live spec,
workflows, and examples.

## What's in this repo

This repo **is** the marketplace. It ships one plugin, `ateam`:

```
.claude-plugin/marketplace.json     — marketplace manifest (lists the plugin)
plugins/ateam/
  .claude-plugin/plugin.json        — plugin manifest + API-key prompt
  .mcp.json                         — connects the A-Team MCP over HTTPS
  skills/ateam/SKILL.md             — the /ateam onboarding skill
  hooks/hooks.json                  — nudges if enabled without a key
  scripts/check-auth.sh
```

The key is entered per-user at install and never stored in this repo.
Volatile content (spec, workflows, examples) stays server-side, delivered live
through the MCP tools; only stable orchestration lives here.

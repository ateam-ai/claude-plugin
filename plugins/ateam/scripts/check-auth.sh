#!/usr/bin/env bash
# SessionStart nudge: fires if the A-Team plugin is enabled without a tenant key.
# The key is exported to hook processes as CLAUDE_PLUGIN_OPTION_API_KEY.
# stdout from a SessionStart hook is added to Claude's context.
if [ -z "${CLAUDE_PLUGIN_OPTION_API_KEY:-}" ]; then
  echo "A-Team: no tenant key configured. Run /plugin, enable \"A-Team\", and paste your key from https://mcp.ateam-ai.com/get-api-key"
fi

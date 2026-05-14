#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

source_path="../wechat-articles/ai-security-scan-skill-tanstack-2026-05-14.md"
tasks_dir="$HOME/Documents/Obsidian Vault/90_Agent/tasks"
drafts_dir="$HOME/Documents/Obsidian Vault/03.公众号/_agent_drafts"

echo "== Agent Network Workbench: article demo =="
echo
echo "What this does:"
echo "1. Starts the local Hub and Dashboard."
echo "2. Creates an article_pipeline task JSON."
echo "3. Generates a local Obsidian article draft."
echo "4. Sends a sample Agent task so it appears in Dashboard > Tasks."
echo

if [ ! -f "$source_path" ]; then
  echo "Missing demo source: $source_path"
  echo "Edit scripts/demo-article-flow.sh and point source_path to a Markdown article."
  exit 1
fi

npm run start:local

echo
echo "== Create task =="
npm run task:article

echo
echo "== Generate draft =="
npm run pilot:article

echo
echo "== Send visible Dashboard task =="
npm run smoke:send-task

latest_task="$(ls -t "$tasks_dir"/article_pipeline_*.json 2>/dev/null | head -n 1 || true)"
latest_draft="$(ls -t "$drafts_dir"/article_pipeline_*.md 2>/dev/null | head -n 1 || true)"

echo
echo "== Demo result =="
echo "Dashboard: http://127.0.0.1:3000"
echo "Task JSON: ${latest_task:-not found}"
echo "Draft MD:  ${latest_draft:-not found}"
echo
echo "How to read the Dashboard:"
echo "- Tasks: the sample send_task should show as delivered."
echo "- Mesh: the six local Agent node configs are the roles."
echo "- Messages: the message log between roles."

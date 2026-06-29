#!/usr/bin/env bash
set -euo pipefail

codex plugin marketplace add tangka/jushou-releases --ref main --json >/dev/null
codex plugin add jushou@jushou --json

plugin_url="codex://plugins/jushou"

if [ "${JUSHOU_OPEN_CODEX_PLUGIN:-1}" = "1" ]; then
  case "$(uname -s)" in
    Darwin)
      open "$plugin_url" || true
      ;;
    Linux)
      xdg-open "$plugin_url" >/dev/null 2>&1 || true
      ;;
    *)
      if command -v cmd.exe >/dev/null 2>&1; then
        cmd.exe /c start "" "$plugin_url" >/dev/null 2>&1 || true
      else
        echo "$plugin_url"
      fi
      ;;
  esac
else
  echo "$plugin_url"
fi

echo "巨手 Codex 插件已安装: jushou@jushou"

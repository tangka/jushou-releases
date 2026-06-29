#!/usr/bin/env bash
set -euo pipefail

json_file="$(mktemp)"
cleanup() {
  rm -f "$json_file"
}
trap cleanup EXIT

codex plugin marketplace add tangka/jushou-releases --ref main --json > "$json_file"
codex plugin add jushou@jushou --json

plugin_url="$(python3 - "$json_file" <<'PY'
import json
import pathlib
import sys
import urllib.parse

data = json.load(open(sys.argv[1], encoding="utf-8"))
marketplace = pathlib.Path(data["installedRoot"]) / ".agents" / "plugins" / "marketplace.json"
print("codex://plugins/jushou?marketplacePath=" + urllib.parse.quote(str(marketplace), safe=""))
PY
)"

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

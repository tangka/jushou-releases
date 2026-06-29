---
name: woa-install
description: "当用户要求安装巨手、设置巨手、配置公众号助手、从 GitHub 链接安装插件，或运行时发现 woa 命令不存在时使用。"
---

# 巨手安装

把巨手 Codex 插件的本地运行引擎安装到当前电脑。插件本身由 Codex marketplace 安装；本流程只安装本地 `woa` 命令和运行文件。

## 工作流

1. 先检查 `woa` 是否已存在：

```bash
command -v woa
```

2. 如果不存在，先判断当前系统，再下载对应安装包。不要在 Windows 上下载 `jushou-macos-*.zip`，也不要在 macOS 上下载 `jushou-windows-*.zip`。

系统判断规则：

- `process.platform === "darwin"` 或终端是 macOS/zsh/bash：用 macOS 包。
- `process.platform === "win32"` 或终端是 Windows PowerShell/CMD：用 Windows 包。
- Linux 暂不支持一键包，直接说明当前版本只支持 macOS 和 Windows。

macOS：

```bash
tmp="$(mktemp -d)"
curl -L -o "$tmp/jushou.zip" "https://github.com/tangka/jushou-releases/releases/download/v0.1.7/jushou-macos-0.1.7.zip"
unzip -q "$tmp/jushou.zip" -d "$tmp"
JUSHOU_INSTALL_CODEX=0 bash "$tmp/jushou-macos-0.1.7/.jushou-payload/install.sh"
```

Windows PowerShell：

```powershell
$tmp = Join-Path $env:TEMP ("jushou-" + [guid]::NewGuid())
New-Item -ItemType Directory -Force -Path $tmp | Out-Null
Invoke-WebRequest -Uri "https://github.com/tangka/jushou-releases/releases/download/v0.1.7/jushou-windows-0.1.7.zip" -OutFile "$tmp\jushou.zip"
Expand-Archive "$tmp\jushou.zip" -DestinationPath $tmp -Force
$env:JUSHOU_INSTALL_CODEX = "0"
powershell -NoProfile -ExecutionPolicy Bypass -File "$tmp\jushou-windows-0.1.7\.jushou-payload\install.ps1"
```

如果不确定系统，先运行：

```bash
node -p "process.platform"
```

返回 `darwin` 用 macOS 包；返回 `win32` 用 Windows 包。

3. 验证安装：

```bash
woa doctor
woa license status
```

4. 如果用户还没有授权，获取授权请求，并提示用户把输出里的 `machineId` 发给微信 `qinbob97`：

```bash
woa license request
```

## 约束

- 不要求 Docker。
- 不打印 AppSecret、access_token、cookies 或原始 env 文件。
- 不把内部健康检查命令当成客户主流程。
- 安装后真正的业务命令仍需有效 license。

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

2. 如果不存在，下载并安装当前版本：

```bash
tmp="$(mktemp -d)"
curl -L -o "$tmp/jushou.zip" "https://github.com/tangka/jushou-releases/releases/download/v0.1.5/jushou-macos-0.1.5.zip"
unzip -q "$tmp/jushou.zip" -d "$tmp"
JUSHOU_INSTALL_CODEX=0 bash "$tmp/jushou-macos-0.1.5/.jushou-payload/install.sh"
```

3. 验证安装：

```bash
woa doctor
woa license status
```

4. 如果用户还没有授权，获取机器码：

```bash
woa license machine-id
```

## 约束

- 不要求 Docker。
- 不打印 AppSecret、access_token、cookies 或原始 env 文件。
- 不把内部健康检查命令当成客户主流程。
- 安装后真正的业务命令仍需有效 license。

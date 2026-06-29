---
name: woa-open
description: "当用户要求打开巨手插件页、打开公众号本地网页、运行 woa open web/plugin、在 Codex 右侧打开 localhost 或展示登录页时使用。"
---

# 巨手打开入口

在 Codex app 内打开网页时，必须优先使用 Codex 右侧内置浏览器，不要让 `woa open web` 弹系统浏览器。

## 打开本地网页

1. 如果 `woa` 命令不存在，先按 `woa-install` 安装本地运行引擎。

2. 运行 CLI 起服务并获取 URL：

```bash
woa open web
```

3. 如果输出里有 `codexRightBrowserUrl`，用 Codex 右侧内置浏览器打开该 URL，并显示给用户。

4. 如果用户明确要求系统浏览器，才运行：

```bash
woa open web --system
```

## 端口默认值

- 默认端口 `3333`。
- 如果 `3333` 被非巨手服务占用，自动尝试 `3335` 到 `3350`。

## 插件页

打开插件页用：

```bash
woa open plugin
```

如果用户要求在 Codex 插件页查看，使用返回的 `codex://` 链接。

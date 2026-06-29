---
name: woa-debug
description: "当用户要求排查 WOA 配置或运行失败时使用：账号配置、AppSecret、API IP 白名单、微信登录、上传错误、缺图、空 bullet、抽取噪声、同步失败、X/Reddit 代理问题或限流。"
---

# 公众号问题排查

在不暴露密钥的前提下，排查本地 WOA 产品问题。

## 产品边界

- 不打印 AppSecret、access_token、cookies 或原始 env 文件。
- 从只读检查开始。
- 区分微信登录过期和微信后台限流。
- 除非 login-check 明确显示过期，否则不要让用户重新扫码。

## 第一组检查

如果 `woa` 命令不存在，先按 `woa-install` 安装本地运行引擎。

```bash
woa doctor
woa account list
woa account test main
```

## 问题映射

- 缺少 AppID/AppSecret：引导用户去微信后台基础配置查看，并存到本地单账号 `.env` 文件，不要发到聊天里。
- API IP 白名单：执行 token 测试；如果微信返回 `40164`，告诉用户要添加的当前出口 IP。
- 正文缺图：检查 Markdown `![...](media/...)`、正文图片数量、文件格式、文件大小和上传元数据。
- 微信编辑器里出现空 bullet：确认 list HTML 已压紧，`ul/ol` 内没有空白文本节点。
- URL 抽取噪声：使用浏览器渲染采集或清洗成稿，不上传原始抽取结果。
- 所有文章阅读数都是 `0` 或 `cgiData not found`：先按限流处理，等 1 到 2 分钟后用一篇已知文章重试。
- login-check 显示过期：运行产品登录流程，让用户扫码。
- X/Reddit 失败：检查代理配置和兜底采集能力。

## 完成汇报

先说最可能原因，再给证据，最后给下一条命令或用户动作。所有敏感信息都要打码。

---
name: woa-url-to-draft
description: "当用户要求把 blog URL、官方公告、更新日志、文档页、X/Reddit 来源或粘贴链接做成微信公众号本地草稿或草稿箱候选时使用。默认生成中文公众号稿，采集素材、生成本地草稿、校验图片和元数据，但不发布。"
---

# 公众号 URL 转草稿

把一个来源 URL 做成本地微信公众号草稿。除非用户明确要求上传，否则只停在本地草稿和校验结果。

## 产品边界

- 使用已安装的 `woa` CLI。
- 不询问、不打印 AppSecret、access_token、cookies 或授权签名。
- 不发布、不群发。产品只写本地草稿和微信公众号后台草稿箱。
- 默认输出中文稿。英文源文要改写成面向中文读者的公众号内容，不直接保留英文正文。

## 工作流

0. 如果 `woa` 命令不存在，先按 `woa-install` 安装本地运行引擎。

1. 检查产品状态：

```bash
woa doctor
woa account list
```

2. 把 URL 拉取到素材库：

```bash
woa url fetch --url "<url>"
```

3. 基于素材生成中文本地草稿：

```bash
woa draft generate
```

4. 校验草稿：

```bash
woa draft validate --draft "<draft-id-or-dir>"
```

5. 如果用户要求上传，交给 `woa-draft-upload` 处理。

## 质量检查

- 正文必须是中文公众号稿，英文源文只作为素材来源。
- 正文图片必须是显式 Markdown 图片引用，不能只有 frontmatter `cover`。
- 正文图片必须是 jpg/png，单张不超过 1 MB。
- SVG 只作为源素材采集；上传微信前需要转换或跳过。
- 尽量保留原始 URL 作为 `source_url` / 微信阅读原文。
- 如果抽取结果包含导航噪声，先清洗成稿，不直接上传原始抽取内容。

## 完成汇报

汇报素材目录、本地草稿目录、正文图片数量、封面路径、校验状态，以及下一步上传命令。

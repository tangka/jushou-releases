---
name: woa-draft-upload
description: "当用户要求上传、推送、重试或校验一个本地微信公众号草稿到后台草稿箱时使用。需要已有本地草稿，绝不发布或群发；上传前健康检查在内部完成。"
---

# 公众号草稿上传

把已有本地草稿上传到微信公众号后台草稿箱。这个流程不会公开发布。

## 产品边界

- 上传前健康检查由 CLI 内部完成；不要把内部健康检查命令当成客户主流程步骤展示。
- 如果当前请求里还没有确认真实上传，上传前必须让用户明确确认。
- 这里不拉取 URL、不改写正文。素材采集和成稿交给 `woa-url-to-draft`。
- 不打印 AppSecret、access_token、cookies、授权签名；非必要不打印上传后的 CDN URL。

## 工作流

0. 如果 `woa` 命令不存在，先按 `woa-install` 安装本地运行引擎。

1. 检查配置：

```bash
woa doctor
woa account test main
```

2. 校验本地草稿：

```bash
woa draft validate --draft "<draft-id-or-dir>"
```

3. 客户确认“上传到草稿箱”后真实上传：

```bash
woa draft upload --draft "<draft-id-or-dir>"
```

4. 如果本地草稿已经上传过，并且用户确认要重新测试上传：

```bash
woa draft upload --draft "<draft-id-or-dir>" --force
```

## 草稿格式要求

- 草稿目录下有主 Markdown 文件。
- frontmatter 包含 `title`。
- frontmatter `cover` 指向本地 jpg/png 封面。
- 可选 `source_url` 或 `content_source_url`。
- 正文图片用 Markdown 显式引用，例如 `![alt](media/file.png)`。

## 常见失败

- `invalid ip ... not in whitelist`：让用户把当前出口 IP 加到微信后台 API IP 白名单。
- 正文图片数是 `0`：说明 frontmatter `cover` 只是微信缩略图，不会出现在正文。
- 图片超过 1 MB：上传前压缩。
- SVG 图片：转成 jpg/png，或跳过正文上传。
- 已存在上传元数据：只有用户确认要生成重复草稿后才使用 `--force`。

## 完成汇报

客户主流程只汇报是否已上传到草稿箱。排障时再汇报健康检查状态、本地元数据路径和正文图片数量。

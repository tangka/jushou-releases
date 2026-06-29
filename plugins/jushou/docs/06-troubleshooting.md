# 常见错误排查

## AppSecret 或 IP 白名单失败

```bash
woa account test main
```

如果返回 `invalid ip ... not in whitelist`,把输出的 IP 加到公众号后台 API IP 白名单。

## 正文没有图片

检查:

- Markdown 正文里是否有 `![alt](media/file.png)`。
- 不要只看 frontmatter `cover`;它只做微信封面。
- 图片格式是否 jpg/png。
- 图片大小是否 <= 1 MB。

## 空 bullet

原因通常是微信编辑器把 `<ul>/<li>` 之间的换行空白当成空列表项。

修复要求:

- publish HTML 里列表应接近 `<ul><li>...</li><li>...</li></ul>`。
- 上传前运行 `woa draft validate`。

## URL 抽取有导航噪声

处理:

- 不要把 `content.md` 原样上传。
- 使用 browser-rendered collector 或草稿清洗步骤。
- 检查正文图是否来自文章主体,不要抓推荐卡片/logo。

## 微信登录和限流

- 登录检查说过期:扫码。
- 批量文章全是 `read=0` 或 `cgiData not found`:先按限流处理,等 1-2 分钟,不要直接要求扫码。
- 请求间隔保持 >= 1.5s。

## X / Reddit 抓取失败

检查:

- `network.proxy` 是否正确。
- Clash/Mihomo 是否运行。
- Reddit RSS fallback 是否可用。
- 外部平台页面结构是否变化。

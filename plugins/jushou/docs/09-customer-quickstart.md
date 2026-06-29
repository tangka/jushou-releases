# 巨手客户从零开始流程

## 1. 初始化

```bash
woa config init
```

## 2. 导入授权

查看授权请求，并把输出里的 `machineId` 发给微信 `qinbob97`：

```bash
woa license request
```

收到 license 后导入：

```bash
woa license import ./license.json
woa license status
```

不导入 license 时，可以配置账号和打开网页，但不能抓取 URL、生成草稿或上传草稿。

## 3. 填公众号配置

```bash
woa account add --id main --name 你的公众号名称
```

编辑：

```text
~/.woa/.env.main
```

填写：

```env
WECHAT_ACCOUNT_KEYWORD=你的公众号名称
WECHAT_ACCOUNT_EXACT=你的公众号名称
WECHAT_APPID=你的AppID
WECHAT_APPSECRET=你的AppSecret
OBSIDIAN_VAULT=/Users/你的用户名/wechat-vault
WECHAT_DRAFT_AUTHOR=你的公众号名称
DRAFT_INCLUDE_COMMENT_SECTION=1
```

## 4. 检查配置

```bash
woa doctor
woa account test main
```

## 5. 打开巨手网页

在 Codex 里：

```bash
woa open web
```

巨手会自动找空闲端口。`3333` 被占用时，会自动换到 `3335` 到 `3350`。

## 6. 扫码登录

网页出现二维码后，用微信扫码并在手机上确认。

登录成功后自动进入看板。

## 7. 输入文章链接

```bash
woa url fetch --url "https://example.com/blog/post"
```

巨手会拉取网页正文、图片和原文链接。

## 8. 生成中文公众号草稿

```bash
woa draft generate
```

生成后的草稿进入本地待发布目录。

## 9. 查看草稿

```bash
woa draft list
```

选择最新草稿。

## 10. 上传到公众号草稿箱

```bash
woa draft upload --draft "<草稿目录名>"
```

巨手会在上传前自动做健康检查。客户不需要单独执行健康检查命令。

## 11. 去公众号后台检查

打开微信公众号后台草稿箱，检查标题、封面、正文图片和阅读原文。

确认无误后，人工发布。

## 边界

- 不需要 Docker。
- 不自动发布。
- 不群发。
- 只上传到草稿箱。
- AppSecret 只保存在本机 `.env`。
- 端口被占用会自动换端口。

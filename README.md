# 巨手 Codex 插件

这是巨手的公开 Codex marketplace 仓库，只发布可安装插件和打包好的运行包，不发布产品源码。

## 给 Codex 的安装方式

把这个链接发给 Codex：

```text
https://github.com/tangka/jushou-releases
```

让 Codex 执行：

```bash
curl -fsSL https://raw.githubusercontent.com/tangka/jushou-releases/main/install-codex.sh | bash
```

这会安装 `jushou@jushou`，并自动打开插件详情页。

手动安装命令：

```bash
codex plugin marketplace add tangka/jushou-releases --ref main
codex plugin add jushou@jushou
```

安装后在 Codex 里选择插件「巨手」。

## 本地运行引擎

Codex 插件安装后，第一次使用巨手时如果本机还没有 `woa` 命令，插件会下载 Release 里的安装包并安装本地运行引擎。

手动安装也可以下载：

```text
https://github.com/tangka/jushou-releases/releases/latest
```

## 授权

未导入 license 时，可以完成插件安装、打开配置页和查看机器码，但不能抓取 URL、生成草稿或上传草稿。

```bash
woa license machine-id
woa license import ./license.json
woa license status
```

## 边界

- 不需要 Docker。
- 不自动发布。
- 不群发。
- 只上传到微信公众号草稿箱。

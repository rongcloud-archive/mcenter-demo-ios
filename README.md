##RongMCenter-Demo

###使用注意
1. 需要使用 pod 安装融云的 SDK，建议先使用 pod repo update 更新 pod 镜像，再执行 pod install。如不安装，Demo 无法成功编译运行。
2. 如需使用自己申请的融云 Appkey 和 Token，替换 Appdelegate.m 中的即可。
3. users_config.json 的格式不可以修改，否则会导致无法正确解析。

###相关文档
1. RongMCenter.framework 库的相关文档请看 [消息中心文档](http://www.rongcloud.cn/docs/mcenter.html)
2. 由于 RongMCenter.framework 库是基于融云的 IMKit 和 IMLib 开发的，所以需要开发者先要了解融云 SDK 的使用。 [融云 SDK 文档连接](http://www.rongcloud.cn/docs/ios.html)
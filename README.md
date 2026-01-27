# ClassIsland.ManagementServer

> [!warning]
> 由于开发者时间精力受限，近期集控服务器暂停开发，不会有任何开发进展。目前集控服务器不做任何可用性和向后兼容性保证，请谨慎使用。开发恢复时间待定。

ClassIsland 集控服务器。

> **注意：本项目是 ClassIsland 集控服务器。如果您要查找 ClassIsland 软件本体，请前往仓库[ClassIsland/ClassIsland](https://github.com/ClassIsland/ClassIsland)**

## 功能

> [!TIP]
>
> 您可以点击下方链接或查看 [ClassIsland 文档](https://docs.classisland.tech) 了解更多。

### 管理后端

- [x] 实例注册与获取
- [x] 实例分组
- [x] 上传档案

### 数据分发

- [x] 按实例与分组拼接数据
- [x] 分发策略
- [x] 分发设置信息
- [x] 分发档案信息
- [x] 使用 grpc 向客户端发送命令
  - [ ] 向客户端发送提醒
  - [ ] 通知客户端更新数据

### API

- [x] API 返回分页

### WebUI

- [x] 批量创建对象
- [x] 管理并分组实例
- [x] 管理并分组档案（课表、时间表、科目）信息
- [x] 上传档案信息
- [ ] 从表格导入课表
- [x] 管理并分组策略
- [x] 管理并分组默认设置

### 用户

- [x] 用户创建与管理
- [x] 用户鉴权
- [x] 用户角色（管理员，教师，访客等）

## 开始使用（预览）

**请确保您的设备满足以下推荐需求：**

- Windows / Linux 系统  
- 已安装[ASP.NET Core 8.0 运行时](https://dotnet.microsoft.com/zh-cn/download/dotnet/8.0)
- 已安装[MySQL 8.0](https://dev.mysql.com/downloads/mysql/8.0.html)

> [!IMPORTANT]
> **本版本为预览版，仅用于测试和开发环境，请勿在生产环境中使用。**  
> 目前项目还在早期开发阶段，可能会出现对数据结构的破坏性更改。

### 下载软件

- [GitHub Releases](https://github.com/ClassIsland/ManagementServer/releases)

### 安装步骤

1. 将压缩包解压到一个**独立的文件夹**（路径中请勿包含中文或特殊字符）
   > ⚠️ 请勿将程序解压至网盘同步目录、【下载】文件夹等可能存在访问限制的路径，否则可能导致**文件读写失败、配置丢失**等问题。
2. 切换到安装目录，然后运行 `setup.ps1`/`setup.sh` 运行安装向导
3. 安装向导完成后，运行 `start.ps1`/`start.sh` 启动服务
4. 如果您是 Linux 用户，并希望长期运行服务，可参考[此文档](https://blog.csdn.net/Pan_peter/article/details/128875714)进行配置

> [!NOTE]
> 如果您遇到任何问题，请前往 [ClassIsland.ManagementServer GitHub 仓库](https://github.com/ClassIsland/ManagementServer) 提交 issue 或查阅相关讨论内容。  

**🚧本项目还在开发中**

#!/usr/bin/env /usr/bin/sh

# 从环境变量读取配置
# 示例环境变量：
# - ConnectionStrings__Production: 数据库连接字符串
# - Kestrel__Endpoints__api__Url: API 端点 URL
# - Kestrel__Endpoints__grpc__Url: gRPC 端点 URL
# - DatabaseType: 数据库类型 (mysql/sqlite)
# - CacheCapacity: 缓存容量

dotnet ./ClassIsland.ManagementServer.Server.dll

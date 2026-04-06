FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# 构建和发布阶段
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .

# 安装 Node.js 和 pnpm 用于前端构建
WORKDIR /src/classisland.managementserver.client
RUN apt-get update && apt-get install -y npm
RUN npm install -g pnpm
RUN pnpm install
RUN pnpm add -D tsx

# 构建和发布后端（前端会在 dotnet publish 时自动构建）
WORKDIR /src/ClassIsland.ManagementServer.Server
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
# 创建 data 目录并复制默认配置文件
RUN mkdir -p ./data
COPY ./ClassIsland.ManagementServer.Server/data/appsettings.example.json ./data/appsettings.json
ENTRYPOINT ["dotnet", "ClassIsland.ManagementServer.Server.dll"]
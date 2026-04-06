FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .

# 安装前端依赖
WORKDIR /src/classisland.managementserver.client
RUN apt-get update && apt-get install -y npm
RUN npm install -g pnpm
RUN pnpm install
RUN pnpm add -D tsx

# 构建后端（前端会在 dotnet build 时自动构建）
WORKDIR /src/ClassIsland.ManagementServer.Server
RUN dotnet restore
RUN dotnet build -c Release -o /app/build

# 发布镜像
FROM build AS publish
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
# 创建 data 目录并复制默认配置文件
RUN mkdir -p ./data
COPY ./ClassIsland.ManagementServer.Server/data/appsettings.example.json ./data/appsettings.json
ENTRYPOINT ["dotnet", "ClassIsland.ManagementServer.Server.dll"]
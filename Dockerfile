FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# 前端构建阶段
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS frontend-build
WORKDIR /src
COPY . .
WORKDIR /src/classisland.managementserver.client
RUN apt-get update && apt-get install -y npm
RUN npm install -g pnpm
RUN pnpm install
RUN pnpm add -D tsx
RUN pnpm run build

# 后端构建和发布阶段
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
# 从前端构建阶段复制构建产物
COPY --from=frontend-build /src/classisland.managementserver.client/dist ./classisland.managementserver.client/dist

FROM build AS publish
WORKDIR /src/ClassIsland.ManagementServer.Server
RUN dotnet restore
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
# 创建 data 目录并复制默认配置文件
RUN mkdir -p ./data
COPY ./ClassIsland.ManagementServer.Server/data/appsettings.example.json ./data/appsettings.json
ENTRYPOINT ["dotnet", "ClassIsland.ManagementServer.Server.dll"]
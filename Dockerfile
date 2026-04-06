FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .

# 构建后端（前端会在 dotnet publish 时自动构建）
WORKDIR /src/ClassIsland.ManagementServer.Server
RUN apt-get update && apt-get install -y npm
RUN npm install -g pnpm
RUN dotnet restore
RUN dotnet build -c Release -o /app/build

FROM build AS publish
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
# 创建 data 目录并复制默认配置文件
RUN mkdir -p ./data
COPY ./ClassIsland.ManagementServer.Server/data/appsettings.json ./data/
ENTRYPOINT ["dotnet", "ClassIsland.ManagementServer.Server.dll"]
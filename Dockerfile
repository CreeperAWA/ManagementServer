FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .

# 构建前端
WORKDIR /src/classisland.managementserver.client
RUN apt-get update && apt-get install -y npm
RUN npm install -g pnpm
RUN pnpm install
# 安装 tsx 以替代 esno
RUN pnpm add -D tsx
# 修改构建脚本，使用 tsx 运行 postBuild.ts
RUN sed -i 's/esno/tsx/g' package.json
RUN pnpm run build

# 构建后端
WORKDIR /src/ClassIsland.ManagementServer.Server
RUN dotnet restore
RUN dotnet build -c Release -o /app/build

FROM build AS publish
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ClassIsland.ManagementServer.Server.dll"]
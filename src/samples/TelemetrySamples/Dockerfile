#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["TelemetrySampleWeb/TelemetrySampleWeb.csproj", "TelemetrySampleWeb/"]
RUN dotnet restore "TelemetrySampleWeb/TelemetrySampleWeb.csproj"
COPY . .
WORKDIR "/src/TelemetrySampleWeb"
RUN dotnet build "TelemetrySampleWeb.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TelemetrySampleWeb.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TelemetrySampleWeb.dll"]
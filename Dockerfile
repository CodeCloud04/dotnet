FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

COPY fixed-dotnet-app/fixed-dotnet-app.csproj ./
RUN dotnet restore

COPY fixed-dotnet-app/. ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "fixed-dotnet-app.dll"]

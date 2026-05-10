# Build Stage
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /source

# Copy solution and project files first for better caching
COPY *.slnx .
COPY src/web-ui/*.csproj src/web-ui/
COPY src/cli/*.csproj src/cli/
COPY src/shapes/*.csproj src/shapes/

RUN dotnet restore

# Copy everything else and build
COPY . .
RUN dotnet publish src/web-ui/web-ui.csproj -c Release -o /app/publish --no-restore

# Runtime Stage
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Expose port 8080 (default for .NET 8+)
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080

ENTRYPOINT ["dotnet", "web-ui.dll"]

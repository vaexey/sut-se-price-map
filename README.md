# price-map

**Web app made to compare prices of different products across multiple stores.**  

# Deployment

## Prerequisites

This project requires [Docker](https://docs.docker.com/engine/install/) version 27.3.1 or newer.  

```
docker -v
```

## Container

Build & run  
```
docker compose up --build
```

Dispose
```
docker compose down
```

# Development

## Prerequisites

This project requires [go](https://go.dev/doc/install) version 1.23.3 or newer and [NodeJS and NPM](https://nodejs.org/en) version 22.0.0 or newer.  

Make sure **go** and **NodeJS**/**npm** is installed correctly.  

```
go version
node -v
npm -v
```

## Container
*Recommended way*

Build & run  
```
docker compose -f compose.dev.yaml up --build
```

Dispose
```
docker compose -f compose.dev.yaml down -v
```

## Atomic

Launch database (through container)  
```
docker compose -f compose.dev.yaml up --build
```

Launch backend  

*Windows:*
```powershell
cd back
go run main.go
```

*Linux:*
```bash
cd back
make run
```

Launch frontend  

```bash
cd front
npm install
npm start
```

The app will be available under http://localhost:4200/  

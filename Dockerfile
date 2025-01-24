# syntax=docker/dockerfile:1.7-labs

# Build ng app
FROM node:22-alpine AS build-front

WORKDIR /dist
COPY /front ./

RUN npm install -g @angular/cli
RUN npm install
RUN npm run build

# Build golang app
FROM golang:1.23 AS build-back

WORKDIR /dist
COPY /back/ /dist/
RUN go mod download

COPY --from=build-front /dist/dist/front/browser /dist/static

RUN GOOS=linux go build -o /sut-se-price-map

CMD ["/sut-se-price-map"]
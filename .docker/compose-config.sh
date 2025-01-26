#!/bin/bash
docker compose -f compose.yaml -f .docker/compose.ci.override.yaml config --no-interpolate --no-path-resolution | tee compose.ci.yaml
docker compose -f compose.yaml -f .docker/compose.dev.override.yaml config --no-interpolate --no-path-resolution | tee compose.dev.yaml
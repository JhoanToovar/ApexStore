#!/usr/bin/env bash
# Levanta los nodos en orden 4 -> 3 -> 2 -> 1. Los nodos 4, 3 y 2 corren en segundo plano con log en logs/; el nodo 1 queda en esta terminal (menú). Antes: docker compose up -d y .env listo.
set -e
cd "$(dirname "$0")/.."
./gradlew --quiet :nodo1-consola:installDist :nodo2-backend:installDist :nodo3-pasarelas:installDist :nodo4-db:installDist
cd scripts
mkdir -p ../logs
PIDS=()
trap 'kill "${PIDS[@]}" 2>/dev/null' EXIT
for n in 4 3 2; do
  ./run-nodo$n.sh > "../logs/nodo$n.log" 2>&1 &
  PIDS+=($!)
  sleep 10
done
./run-nodo1.sh

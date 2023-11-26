#!/bin/bash

if [[ -z "${OLLAMA_MODELS}" ]]; then
  echo "[start.sh] Setting OLLAMA_MODELS environment variable to default value: /workspace/models"
  : "${OLLAMA_MODELS:=/workspace/models}"
fi

mkdir -p ${OLLAMA_MODELS}/downloads    
mkdir -p /scripts/log

/bin/bash /scripts/load-huggingface-model.sh | tee /scripts/log/load-huggingface-model.log &

/bin/ollama serve
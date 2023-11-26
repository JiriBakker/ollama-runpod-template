#!/bin/bash

function log () {
  echo "[load-huggingface-model.sh] $1"
}

if [[ -z "${OLLAMA_MODELS}" ]]; then
  log "Setting OLLAMA_MODELS environment variable to default value: /workspace/models"
  : "${OLLAMA_MODELS:=/workspace/models}"
fi

if [[ -z "${OLLAMA_MODEL_FILENAME}" ]]; then
  log "OLLAMA_MODEL_FILENAME environment variable not set. Aborting..."
  exit 1
fi

if [[ -z "${HUGGINGFACE_REPO}" ]]; then
  log "HUGGINGFACE_REPO environment variable not set. Aborting..."
  exit 2
fi

if [[ -z "${OLLAMA_MODEL_SHORTNAME}" ]]; then
  log "OLLAMA_MODEL_SHORTNAME environment variable not set. Defaulting to: ${OLLAMA_MODEL_FILENAME} (value of OLLAMA_MODEL_FILENAME environment variable)"
  : "${OLLAMA_MODEL_SHORTNAME:=OLLAMA_MODEL_FILENAME}"
fi

if [[ -z "${OLLAMA_NUM_GPU}" ]]; then
  log "OLLAMA_NUM_GPU environment variable not set. Defaulting to: 50"
  : "${OLLAMA_NUM_GPU:=50}"
fi

log "Attempting to download $OLLAMA_MODEL_FILENAME from $HUGGINGFACE_REPO..."

huggingface-cli download \
    $HUGGINGFACE_REPO \
    $OLLAMA_MODEL_FILENAME \
    --cache-dir ${OLLAMA_MODELS}/downloads \
    --local-dir ${OLLAMA_MODELS}/downloads \
    --local-dir-use-symlinks False

log "Generating Modelfile..."

rm /workspace/Modelfile-${OLLAMA_MODEL_SHORTNAME}
echo "FROM /workspace/jiri/downloads/phind-codellama-34b-v2.Q4_K_M.gguf" > /workspace/Modelfile-${OLLAMA_MODEL_SHORTNAME}
echo "PARAMETER num_gpu ${OLLAMA_NUM_GPU}" > /workspace/Modelfile-${OLLAMA_MODEL_SHORTNAME}

log "Loading model into ollama..."

ollama create ${OLLAMA_MODEL_SHORTNAME} -f /workspace/jiri/Modelfile-${OLLAMA_MODEL_SHORTNAME}

log "Model ${OLLAMA_MODEL_SHORTNAME} successfully loaded!"
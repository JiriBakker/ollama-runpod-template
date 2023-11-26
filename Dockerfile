FROM ollama/ollama:latest

ENV OLLAMA_MODELS=/workspace/models

RUN apt-get update && \
    apt-get install pip bash -y && \
    pip install huggingface-hub    

COPY scripts/ /scripts/

ENTRYPOINT ["/bin/bash"]

CMD ["/scripts/start.sh"]
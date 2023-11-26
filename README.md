# Ollama RunPod.io custom template

This docker image is intended to be used as a RunPod.io custom template. It is 
based upon the default [`ollama/ollama`](https://hub.docker.com/r/ollama/ollama) 
Docker image, but supports automatic loading of models from 
[Huggingface](https://huggingface.co/models).

## Usage

Create a RunPod.io custom template based on this docker image, exposing port 11434. 
Then set the environment variables listed below to the appropriate values (in the template
or in the overrides when deploying).

Then deploy the custom template (preferrably with a network volume mounted at `/workspace`).

### Environment Variables

* `HUGGINGFACE_REPO` - Name of the HuggingFcae model repository (eg. `TheBloke/Phind-CodeLlama-34B-v2-GGUF`)
* `OLLAMA_MODEL_FILENAME` - Filename of specific file to be downloaded (eg. `phind-codellama-34b-v2.Q4_K_M.gguf`)
* `OLLAMA_MODEL_SHORTNAME` - Shorthand reference to model (defaults to `OLLAMA_MODEL_FILENAME` value)
* `OLLAMA_NUM_GPU` - Specify how many layers Ollama should offload to a GPU (defaults to `50`)
* `OLLAMA_MODELS` - Directory where Ollama models will be stored. If you have not mounted a network volume you probably need to set this explicitly (defaults to `/workspace/models`)
#!/bin/bash
# Skill: List Models
# Description: Lists all AI models currently configured in the YAML files.

echo "--- 🤖 Available Models ---"
echo ""
echo "NVIDIA Models:"
grep "model_name:" litellm_config_nvidia.yaml | sed 's/.*: //' | sort -u | sed 's/^/  - /'

echo ""
echo "Google Models:"
grep "model_name:" litellm_config_google.yaml | sed 's/.*: //' | sort -u | sed 's/^/  - /'

echo ""
echo "DeepSeek Models:"
grep "model_name:" litellm_config_deepseek.yaml | sed 's/.*: //' | sort -u | sed 's/^/  - /'

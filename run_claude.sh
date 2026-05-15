#!/bin/bash

# Unified Claude Code Runner
# Usage: ./run_claude.sh [model_name]
# Example: ./run_claude.sh gemini-pro
# Default: qwen3

MODEL=${1:-"qwen3"}

echo "=========================================="
echo " Starting Claude Code with $MODEL..."
echo "=========================================="

# ---- STEP 1: Cleanup ----
pkill -f litellm 2>/dev/null
lsof -ti:4000 | xargs kill -9 2>/dev/null
sleep 2

# ---- STEP 2: Load Environment ----
if [ -f ".env" ]; then
    export $(grep -v '^#' .env | xargs)
fi

# ---- STEP 3: Setup Claude Code Env ----
export ANTHROPIC_BASE_URL="http://127.0.0.1:4000"
# Auth token is required by Claude Code but ignored by LiteLLM proxy
export ANTHROPIC_AUTH_TOKEN="dummy-token"

# ---- STEP 4: Start Proxy ----
if [ "$MODEL" = "auto" ]; then
    echo "Starting LiteLLM proxy in AUTO mode (Dynamic Routing)..."
    litellm --config litellm_config.yaml > litellm_proxy.log 2>&1 &
else
    echo "Starting LiteLLM proxy with $MODEL..."
    litellm --config litellm_config.yaml --model $MODEL > litellm_proxy.log 2>&1 &
fi
LITELLM_PID=$!

echo "Waiting for proxy to boot..."
sleep 6

# ---- STEP 5: Launch Claude Code ----
if ps -p $LITELLM_PID > /dev/null; then
    echo "✅ Proxy is running on http://127.0.0.1:4000"
    echo "Launching Claude Code..."
    claude
    
    kill $LITELLM_PID 2>/dev/null
else
    echo "❌ Error: LiteLLM proxy failed to start."
    cat litellm_proxy.log
fi

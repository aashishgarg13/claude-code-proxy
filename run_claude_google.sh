#!/bin/bash

echo "=========================================="
echo " Starting Claude Code with Google Gemini..."
echo "=========================================="

# ---- STEP 1: Kill ANY old litellm proxy processes ----
echo "Killing any old proxy processes..."
pkill -f litellm 2>/dev/null
sleep 2  # Give them time to die

# Also free up port 4000 if anything is stuck on it
lsof -ti:4000 | xargs kill -9 2>/dev/null
sleep 1

# ---- STEP 2: Check if litellm is installed ----
if ! command -v litellm &> /dev/null
then
    echo "litellm proxy could not be found. Installing it now..."
    pip install 'litellm[proxy]'
fi

# ---- STEP 3: Load API key from .env file ----
if [ -f ".env" ]; then
    export $(grep -v '^#' .env | xargs)
fi

if [ -z "$GEMINI_API_KEY" ]; then
    echo "Error: GEMINI_API_KEY is not set. Please add it to your .env file."
    exit 1
fi

# ---- STEP 4: Set up Claude Code environment variables ----
export ANTHROPIC_BASE_URL="http://127.0.0.1:4000"
export ANTHROPIC_AUTH_TOKEN="dummy-token"

# ---- STEP 5: Start a FRESH LiteLLM Proxy ----
echo "Starting LiteLLM proxy with Google Gemini 1.5 Pro..."
litellm --config litellm_config_google.yaml > litellm_proxy.log 2>&1 &
LITELLM_PID=$!

echo "Waiting for proxy to boot..."
sleep 6

# ---- STEP 6: Verify proxy is running ----
if ps -p $LITELLM_PID > /dev/null; then
    echo "✅ Proxy is running on http://127.0.0.1:4000"
    echo "------------------------------------------"
    
    # Check if Claude Code is installed
    if ! command -v claude &> /dev/null
    then
        echo "Claude Code CLI not found. Installing it via npm..."
        npm install -g @anthropic-ai/claude-code
    fi

    # Launch Claude Code with Haiku model (lighter, works better with proxies)
    echo "Launching Claude Code..."
    echo "💡 TIP: If you see a model error, type /model and pick Haiku (option 4)"
    claude

    # When Claude exits, clean up
    echo "Cleaning up proxy server..."
    kill $LITELLM_PID 2>/dev/null
else
    echo "❌ Error: LiteLLM proxy failed to start."
    echo "Check the log: cat litellm_proxy.log"
fi

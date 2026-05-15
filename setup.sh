#!/bin/bash
# Helper to set up API keys correctly

echo "--- 🔑 Claude Code Proxy Setup ---"

# 1. Ask for NVIDIA Key
read -p "Enter your NVIDIA API Key (starts with nvapi-): " KEY

if [[ $KEY != nvapi-* ]]; then
    echo "⚠️ Warning: NVIDIA keys usually start with 'nvapi-'. Double-check your key."
fi

# 2. Save to .env
echo "NVIDIA_API_KEY=\"$KEY\"" > .env
echo "GEMINI_API_KEY=\"PASTE_YOUR_GEMINI_KEY_HERE\"" >> .env

echo "✅ Created .env with your key."
echo "🚀 You can now run ./run_claude_nvidia.sh"

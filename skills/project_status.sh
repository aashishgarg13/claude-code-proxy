#!/bin/bash
# Skill: Project Status
# Description: Checks the health of the LiteLLM proxy and environment.

echo "--- 🔍 Proxy Health Check ---"
if lsof -ti:4000 > /dev/null; then
    echo "✅ Proxy is ALIVE on port 4000"
else
    echo "❌ Proxy is DOWN"
fi

echo ""
echo "--- 🔑 Environment Check ---"
if [ -f ".env" ]; then
    echo "✅ .env file exists"
    if grep -q "NVIDIA_API_KEY" .env; then echo "  - NVIDIA Key: Configured"; fi
    if grep -q "GEMINI_API_KEY" .env; then echo "  - Gemini Key: Configured"; fi
else
    echo "❌ .env file missing"
fi

echo ""
echo "--- 📂 Directory Stats ---"
echo "Files in project: $(ls -1 | wc -l)"

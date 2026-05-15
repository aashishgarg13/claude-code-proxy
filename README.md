# 🚀 Claude Code: Flagship Models + Multi-Key Failover

Run Anthropic's **Claude Code** CLI using the world's best open-weights models (NVIDIA NIM) and Google Gemini — for **FREE** with automatic rate-limit handling.

This repository features a unified **LiteLLM Proxy** setup that enables "impossible" coding workflows by rotating multiple API keys automatically when limits are hit.

---

## 🔥 Key Features

- **🏆 Flagship Coder Support**: Out-of-the-box support for the latest models:
  - `Qwen3-Next` (Flagship coding performance)
  - `DeepSeek V4 Pro` (State-of-the-art reasoning)
  - `Gemini 3.1 Pro` (Massive context & intelligence)
  - `Kimi K2.6` (Long-horizon planning)
- **🔄 Multi-Key Failover**: Have 2 keys? Use both! If Key 1 hits a rate limit, the proxy automatically switches to Key 2 and cools down Key 1. No more `429: Rate Limit Exceeded` interruptions.
- **⚡ Unified Runner**: One script to rule them all. Switch models with a single argument.
- **🔌 Zero Config for Claude**: Works natively with the official `@anthropic-ai/claude-code` CLI.

---

## 🛠️ Setup

1. **Install Dependencies**:
   ```bash
   pip install 'litellm[proxy]'
   npm install -g @anthropic-ai/claude-code
   ```

2. **Configure Keys**:
   Copy `.env.example` to `.env` and add your keys (2 per provider for best results):
   ```bash
   cp .env.example .env
   ```

3. **Launch**:
   ```bash
   # Default (Qwen3-Next)
   ./run_claude.sh

   # Or specify your model
   ./run_claude.sh gemini-pro
   ./run_claude.sh deepseek
   ```

---

## 🧠 Why use this? (LinkedIn Highlight)

Most developers get frustrated by free-tier rate limits. This project solves that by implementing **usage-based routing**. 

By listing multiple deployments of the same model with different keys, LiteLLM acts as a "Smart Load Balancer". If you're deep in a coding session and hit a limit, the system heals itself in the background so you never lose your flow.

---

## 🕵️‍♂️ Prompts to Try

Claude Code isn't just a chatbot; it's an agent. Try these:

1. **Architecture**: *"Analyze this directory and suggest a cleaner folder structure based on modern best practices."*
2. **Refactoring**: *"Find all files using the old NVIDIA_API_KEY variable and update them to use the new numbered key system."*
3. **Frontend**: *"Create a modern glassmorphism landing page with index.html and a separate CSS file. Use smooth scroll animations."*

---

## 📜 How it works
The `run_claude.sh` script boots a local LiteLLM proxy that:
1. Translates Anthropic's unique API parameters into standard formats.
2. Manages a "Cooldown" queue for rate-limited keys.
3. Automatically cleans up background processes when you exit.

# 🚀 Claude Code: Flagship Models + Multi-Key Failover

Run Anthropic's **Claude Code** CLI using the world's best open-weights models (NVIDIA NIM) — for **FREE** with automatic rate-limit handling.

This repository features a unified **LiteLLM Proxy** setup that enables "impossible" coding workflows by rotating multiple API keys automatically when limits are hit.

---

## 🔥 Key Features

- **🏆 Flagship Coder Support**: Out-of-the-box support for the latest models:
  - `Qwen3-Next` (Flagship coding performance)
  - `DeepSeek V4 Pro` (State-of-the-art reasoning)
  - `Kimi K2.6` (Long-horizon planning)
- **🔄 Multi-Key Failover**: Have 2 keys? Use both! If Key 1 hits a rate limit, the proxy automatically switches to Key 2 and cools down Key 1. No more `429: Rate Limit Exceeded` interruptions.
- **⚡ Unified Runner**: One script to rule them all. Switch models with a single argument.
- **🛠️ Custom Claude Skills**: Pre-configured scripts in `skills/` that Claude can use to check project health and manage models.
- **🔌 Zero Config for Claude**: Works natively with the official `@anthropic-ai/claude-code` CLI.

---

## 🛠️ Setup

1. **Install Dependencies**:
   ```bash
   pip install 'litellm[proxy]'
   npm install -g @anthropic-ai/claude-code
   ```

2. **Configure Keys**:
   Copy `.env.example` to `.env` and add your NVIDIA API keys (2 keys for best results):
   ```bash
   cp .env.example .env
   ```

3. **Launch**:

   **🍎 macOS / 🐧 Linux**
   Open your terminal, navigate to the repository folder, and run the script:
   ```bash
   cd /Users/aashishgarg/Downloads/Cluade
   chmod +x run_claude.sh  # Make it executable (first time only)
   ./run_claude.sh
   ```

   **🪟 Windows**
   Use **Git Bash** (comes with Git for Windows) or **WSL** (Windows Subsystem for Linux) to run the bash script:
   ```bash
   cd /c/Users/aashishgarg/Downloads/Cluade  # Adjust for your drive if not C:
   bash run_claude.sh
   ```

   **💻 VS Code (Recommended)**
   If you are using VS Code, you can run Claude Code directly alongside your codebase:
   1. Open the Integrated Terminal (`Ctrl + \`` or `Cmd + \`` on Mac).
   2. Ensure you are in the project folder.
   3. Run `./run_claude.sh` to start the proxy and the Claude interface inside VS Code.

   **🎯 Switch Models Instantly**
   Want to use a different model? Just pass the name as an argument:
   ```bash
   ./run_claude.sh auto         # 🌟 DYNAMIC MODE: Routes heavy logic to DeepSeek, fast tasks to Qwen!
   ./run_claude.sh deepseek     # Runs DeepSeek V4 Pro
   ./run_claude.sh kimi         # Runs Kimi K2.6
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

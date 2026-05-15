# Claude Code Project Instructions

## CRITICAL: File Operations
When using any tool to write, read, or edit files (e.g., `Write`, `Edit`, `Read`), you **MUST ALWAYS** use the absolute, full path of the file. 

Current Working Directory: `/Users/aashishgarg/Downloads/Cluade/`

**Correct Example:** `/Users/aashishgarg/Downloads/Cluade/index.html`
**Incorrect Example:** `index.html`

Failure to use absolute paths will result in an "Error writing file" message.

## 💰 Token Saving & Efficiency
- **Be Concise**: Keep explanations short. Focus on the code.
- **Efficient Reading**: When reading files, only read the necessary sections. Use line ranges if possible.
- **No Redundancy**: Do not repeat the entire content of a file back in the chat if you are only changing a small part.
- **Minimize Context**: Avoid reading large binary files or irrelevant directories (respect `.claudeignore`).

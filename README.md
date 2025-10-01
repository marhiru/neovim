
# 💤 My Neovim Configs  

Welcome to my personal Neovim setup! 🚀  
This repository contains all my configuration files, plugins, and custom tweaks for making Neovim a powerful and modern development environment.  

---

## 💻 My Environments  

I work with two main setups, one on **Ubuntu 24.04** and another on **Windows**.  
Each one has its own terminal + shell combo, but **Neovim** stays as the core of my workflow.  

### 🐧 Ubuntu 24.04  

- **Terminal:** [Ghostty](https://ghostty.org/)  
- **Shell:** [Oh My Fish](https://github.com/oh-my-fish/oh-my-fish) (Fish shell framework)  
- **Editors:**  
  - [Cursor](https://cursor.sh/) for some tasks  
  - **Neovim 0.11** (main editor and where all configs from this repo apply)  

### 🪟 Windows  

- **Terminal:** [Alacritty](https://alacritty.org/)  
- **Shell:** [PowerShell](https://learn.microsoft.com/en-us/powershell/) with [Starship](https://starship.rs/) prompt  
- **Editor:** **Neovim** (fully configured with the same setup as Ubuntu)  

---

## ⚙️ Features of My Neovim Setup  

- Built around **LazyVim** for plugin management and sane defaults  
- Configured to work seamlessly across both Linux and Windows  
- Strong focus on **LSP support** and **formatting**  
- Custom **keybindings** for:  
  - Escaping insert mode with `kj`  
  - Automatically saving and formatting files on escape  
- Experiments with macros (like inserting `console.log`)  
- Integration with external formatters (Neoformat fallback)  

---

## 📦 Plugins & Tools  

Some highlights from my setup:  

- **LazyVim** → Plugin manager and base setup  
- **LSP Clients** → Language Server Protocol support for various languages  
- **Neoformat** → Formatter fallback when LSP formatting isn’t available  
- **Custom Macros & Mappings** → For quick logging, formatting, and saving  

---

## 🔑 Keybindings  

- `kj` → Exit insert mode, save file, and trigger formatter (via LSP or Neoformat)  
- Macro on register `l` → Inserts `console.log()` quickly in code  

---

## 🛠️ Why This Setup?  

I wanted something:  

- Consistent across **Ubuntu** and **Windows**  
- That blends well with my **terminal + shell workflow**  
- That automates boring tasks like formatting and saving  
- Yet remains **hackable and customizable** as I keep learning Neovim  

---

## 📷 Screenshots (coming soon)

---

## 🚀 Getting Started  

Clone this repo into your Neovim config folder:  

```bash
# Linux
git clone https://github.com/marhiru/neovim ~/.config/nvim

# Windows (PowerShell)
git clone https://github.com/marhiru/neovim $env:LOCALAPPDATA\nvim

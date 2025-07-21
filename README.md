# 🧹 StartIsBack Full Reset Script (PowerShell)

A complete PowerShell tool to **fully clean up all traces of StartIsBack** from your Windows system. This script is designed for users who want to **completely remove registry entries, orphaned CLSID keys**, and ensure a clean environment for a fresh install or total uninstallation.

---

## ⚙️ Features

- ✅ Deletes all known **StartIsBack registry keys** (HKCU/HKLM, including Wow6432Node)
- ✅ Cleans orphaned **CLSID registry entries**
- ✅ Includes user confirmation to prevent accidental execution
- ✅ **Restarts Windows Explorer** automatically after cleanup
- ✅ Minimal and safe – no external tools needed

---

## 📦 What It Removes

- `HKEY_CURRENT_USER\Software\StartIsBack`
- `HKEY_LOCAL_MACHINE\Software\StartIsBack`
- `HKEY_LOCAL_MACHINE\Software\Wow6432Node\StartIsBack`
- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\StartIsBack`
- `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall\StartIsBack`
- Orphaned `CLSID` keys with:
  - No subkeys
  - No `(default)` property value

---

## 🚀 Usage

> ⚠️ Make sure to save your work. The script will close all File Explorer windows and restart `explorer.exe`.

### 1. Open PowerShell as Administrator

### 2. Run the Script

```powershell
.\StartIsBack-Reset.ps1

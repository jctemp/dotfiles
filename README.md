# dotfiles

```powershell
# Optional: Pre-install winget
& "./scripts/install-winget.ps1"

# Essentials
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
& "./setup.ps1"

# Fonts for better support
& "./scripts/install-fonts.ps1"

# General apps (Note: winget has more apps)
& "./scripts/install-apps.ps1" "./scripts/apps-winget.txt"
# Alternative: 
& "./scripts/install-apps.ps1" "./scripts/apps-scoop.txt"
```

@echo off
chcp 65001 >nul
color 5F
title ARTIZEN - Creer les raccourcis du Bureau
cd /d "%~dp0"

echo ============================================================
echo    CREER LES RACCOURCIS SUR LE BUREAU DE CE PC
echo ============================================================
echo.
echo A lancer une fois sur chaque PC : les raccourcis pointeront
echo vers le bon dossier, quel que soit le nom d'utilisateur.
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$repo = '%CD%';" ^
  "$desktop = [Environment]::GetFolderPath('Desktop');" ^
  "$shell = New-Object -ComObject WScript.Shell;" ^
  "$boutons = @(" ^
  "  @{F='1-RECUPERER.bat'; N='1. ARTIZEN - RECUPERER (en arrivant)'; I='shell32.dll,46'}," ^
  "  @{F='2-SAUVEGARDER.bat'; N=\"2. ARTIZEN - SAUVEGARDER (avant d'eteindre)\"; I='shell32.dll,45'}," ^
  "  @{F='3-INSTALLER-PROJET.bat'; N='3. ARTIZEN - INSTALLER le projet'; I='shell32.dll,162'}," ^
  "  @{F='4-NETTOYER.bat'; N='4. ARTIZEN - NETTOYER le PC'; I='shell32.dll,32'}" ^
  ");" ^
  "foreach ($b in $boutons) {" ^
  "  $t = Join-Path $repo $b.F;" ^
  "  if (-not (Test-Path $t)) { Write-Host ('  [X] introuvable : ' + $b.F); continue };" ^
  "  $s = $shell.CreateShortcut((Join-Path $desktop ($b.N + '.lnk')));" ^
  "  $s.TargetPath = $t; $s.WorkingDirectory = $repo; $s.IconLocation = $b.I;" ^
  "  $s.Save(); Write-Host ('  [OK] ' + $b.N)" ^
  "}"

echo.
echo ============================================================
echo    [OK] Raccourcis crees sur le Bureau
echo ============================================================
echo.
pause

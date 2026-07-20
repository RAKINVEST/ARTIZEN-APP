@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
color 2F
title ARTIZEN - RECUPERER (a faire en arrivant)
cd /d "%~dp0.."

set "SESSIONS_LOCAL=%USERPROFILE%\.claude\projects"
set "SESSIONS_BACKUP=%USERPROFILE%\OneDrive\Artizen-Claude-Sessions"

echo ============================================================
echo    RECUPERER  -  A FAIRE EN ARRIVANT SUR CE PC
echo ============================================================
echo.
echo Dossier : %CD%
echo.

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
  echo [ERREUR] Ce dossier n'est pas un depot git.
  echo.
  pause
  exit /b 1
)

REM --- Garde-fou : du travail local non sauvegarde serait ecrase ---
set "DIRTY="
for /f "delims=" %%A in ('git status --porcelain') do set "DIRTY=1"

if defined DIRTY (
  echo [ATTENTION] Ce PC contient du travail NON sauvegarde :
  echo.
  git status --short
  echo.
  echo   Recuperer maintenant peut entrer en conflit avec ce travail.
  echo   Le plus sur : annuler, cliquer sur 2-SAUVEGARDER.bat, puis revenir ici.
  echo.
  choice /C ON /N /M "Continuer quand meme ? [O]ui / [N]on : "
  if errorlevel 2 (
    echo.
    echo Annule. Lance 2-SAUVEGARDER.bat d'abord.
    echo.
    pause
    exit /b 0
  )
)

echo.
echo --- 1/2  Recuperation du code depuis GitHub ----------------
git pull --rebase
if errorlevel 1 (
  echo.
  echo [ERREUR] La recuperation a echoue.
  echo   S'il y a un conflit, dis-le a Claude : il t'aidera a le resoudre.
  echo.
  pause
  exit /b 1
)

echo.
echo --- 2/2  Recuperation des conversations Claude -------------
if not exist "%SESSIONS_BACKUP%" (
  echo    Aucune conversation sauvegardee sur OneDrive pour l'instant.
  goto :done
)
if not exist "%SESSIONS_LOCAL%" mkdir "%SESSIONS_LOCAL%"
REM /XO : ne jamais ecraser une conversation locale plus recente
robocopy "%SESSIONS_BACKUP%" "%SESSIONS_LOCAL%" /E /XO /NFL /NDL /NJH /NJS /NP >nul
if errorlevel 8 (
  echo    [ATTENTION] La copie des conversations a rencontre un probleme.
) else (
  echo    Conversations de l'autre PC recuperees.
)

:done
echo.
echo ============================================================
echo    [OK] TU ES A JOUR - bon travail
echo ============================================================
echo.
echo Pour retrouver une conversation precedente : ouvre Claude Code
echo dans ce dossier et tape  claude --resume
echo.
pause

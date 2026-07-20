@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
color 4F
title ARTIZEN - SAUVEGARDER (a faire avant d'eteindre)
cd /d "%~dp0.."

set "SESSIONS_LOCAL=%USERPROFILE%\.claude\projects"
set "SESSIONS_BACKUP=%USERPROFILE%\OneDrive\Artizen-Claude-Sessions"

echo ============================================================
echo    SAUVEGARDER  -  A FAIRE AVANT D'ETEINDRE LE PC
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

echo --- 1/3  Ce qui va etre sauvegarde -------------------------
git status --short
echo.

git add -A
git diff --cached --quiet
if not errorlevel 1 (
  echo    Aucune modification de code a sauvegarder.
  goto :sessions
)

set "MSG="
set /p "MSG=Message de sauvegarde (Entree = automatique) : "
if "!MSG!"=="" set "MSG=Sauvegarde du %DATE% a %TIME%"

echo.
echo --- 2/3  Enregistrement (commit) ---------------------------
git commit -m "!MSG!"
if errorlevel 1 (
  echo [ERREUR] L'enregistrement a echoue.
  echo.
  pause
  exit /b 1
)

echo.
echo --- 3/3  Envoi vers GitHub (push) --------------------------
git push
if errorlevel 1 (
  echo.
  echo [ERREUR] L'envoi a echoue.
  echo   Causes possibles : pas de connexion, ou identifiants GitHub a saisir.
  echo   Ton travail EST enregistre en local : relance ce bouton plus tard.
  echo.
  pause
  exit /b 1
)

:sessions
echo.
echo --- Sauvegarde des conversations Claude --------------------
if not exist "%SESSIONS_LOCAL%" (
  echo    Aucune conversation locale trouvee, rien a copier.
  goto :done
)
if not exist "%SESSIONS_BACKUP%" mkdir "%SESSIONS_BACKUP%"
robocopy "%SESSIONS_LOCAL%" "%SESSIONS_BACKUP%" /E /XO /NFL /NDL /NJH /NJS /NP >nul
if errorlevel 8 (
  echo    [ATTENTION] La copie des conversations a rencontre un probleme.
) else (
  echo    Conversations copiees vers OneDrive.
)

:done
echo.
echo ============================================================
echo    [OK] TOUT EST SAUVEGARDE - tu peux eteindre le PC
echo ============================================================
echo.
echo Sur l'autre PC : clique sur 1-RECUPERER.bat en arrivant.
echo.
pause

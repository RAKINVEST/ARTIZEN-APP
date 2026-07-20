@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
color 6F
title ARTIZEN - NETTOYER LE PC
cd /d "%~dp0.."

echo ============================================================
echo    NETTOYER  -  liberer de la place sur ce PC
echo ============================================================
echo.
echo Ce nettoyage SUPPRIME :
echo    - les fichiers de compilation de l'application (frontend\build)
echo    - les caches Python (__pycache__)
echo    - les images Docker inutilisees et le cache de construction
echo.
echo Il NE TOUCHE PAS :
echo    - ta base de donnees (tes clients, articles, devis)
echo    - ton fichier .env
echo    - ton code, ni tes conversations Claude
echo.

REM --- Garde-fou : ne jamais nettoyer par-dessus du travail non sauvegarde ---
git rev-parse --is-inside-work-tree >nul 2>&1
if not errorlevel 1 (
  set "DIRTY="
  for /f "delims=" %%A in ('git status --porcelain') do set "DIRTY=1"
  if defined DIRTY (
    echo [ATTENTION] Tu as du travail NON sauvegarde :
    echo.
    git status --short
    echo.
    echo   Le nettoyage ne l'effacera pas, mais le plus sur reste de
    echo   cliquer d'abord sur 2-SAUVEGARDER.bat.
    echo.
  )
)

choice /C ON /N /M "Lancer le nettoyage ? [O]ui / [N]on : "
if errorlevel 2 (
  echo.
  echo Annule, rien n'a ete supprime.
  echo.
  pause
  exit /b 0
)

echo.
echo --- 1/3  Fichiers de compilation de l'application ----------
pushd frontend
call flutter clean
if errorlevel 1 (
  echo    [ATTENTION] flutter clean a echoue - suppression manuelle.
  if exist "build" rmdir /s /q "build"
  if exist ".dart_tool" rmdir /s /q ".dart_tool"
)
popd
echo    Fait.

echo.
echo --- 2/3  Caches Python ------------------------------------
set "PYCACHE=0"
for /f "delims=" %%D in ('dir /s /b /ad "backend\__pycache__" 2^>nul') do (
  rmdir /s /q "%%D" 2>nul
  set /a PYCACHE+=1
)
echo    !PYCACHE! dossier(s) __pycache__ supprime(s).

echo.
echo --- 3/3  Docker : images inutilisees et cache -------------
docker info >nul 2>&1
if errorlevel 1 (
  echo    Docker n'est pas demarre - etape ignoree.
) else (
  echo    Suppression des images sans nom...
  docker image prune -f
  echo    Suppression du cache de construction...
  docker builder prune -f
  echo    Fait. Base de donnees et conteneurs conserves.
)

echo.
echo ============================================================
echo    [OK] NETTOYAGE TERMINE
echo ============================================================
echo.
echo Au prochain lancement, la 1re compilation sera plus longue
echo (les fichiers supprimes se regenerent tout seuls) : c'est normal.
echo.
pause

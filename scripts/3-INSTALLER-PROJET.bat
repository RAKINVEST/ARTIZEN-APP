@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
color 1F
title ARTIZEN - INSTALLER LE PROJET
cd /d "%~dp0.."

echo ============================================================
echo    INSTALLER LE PROJET  (a faire une fois par PC)
echo ============================================================
echo.
echo Dossier : %CD%
echo.

REM ---------- 1. Verification des outils ----------
echo --- 1/4  Verification des outils ---------------------------
set "MANQUE="

git --version >nul 2>&1
if errorlevel 1 (echo    [X] git        MANQUANT & set "MANQUE=1") else (echo    [OK] git)

docker --version >nul 2>&1
if errorlevel 1 (echo    [X] docker     MANQUANT & set "MANQUE=1") else (echo    [OK] docker)

flutter --version >nul 2>&1
if errorlevel 1 (echo    [X] flutter    MANQUANT & set "MANQUE=1") else (echo    [OK] flutter)

if defined MANQUE (
  echo.
  echo [ERREUR] Installe d'abord les outils marques MANQUANT, puis relance.
  echo   git     : https://git-scm.com/download/win
  echo   docker  : https://www.docker.com/products/docker-desktop/
  echo   flutter : https://docs.flutter.dev/get-started/install/windows
  echo.
  pause
  exit /b 1
)

REM ---------- 2. Fichier de configuration ----------
echo.
echo --- 2/4  Fichier de configuration (.env) -------------------
if exist ".env" (
  echo    .env deja present, conserve tel quel.
) else (
  if exist ".env.example" (
    copy ".env.example" ".env" >nul
    echo    .env cree a partir de .env.example.
    echo    [!] Pense a y mettre un vrai mot de passe et une vraie cle secrete.
  ) else (
    echo    [ATTENTION] .env.example introuvable, .env non cree.
  )
)

REM ---------- 3. Serveur + base de donnees ----------
echo.
echo --- 3/4  Demarrage du serveur et de la base ----------------
echo    (Docker Desktop doit etre lance - patiente, le 1er build est long)
docker compose up -d --build
if errorlevel 1 (
  echo.
  echo [ERREUR] Le demarrage a echoue.
  echo   Verifie que Docker Desktop est bien demarre, puis relance ce bouton.
  echo.
  pause
  exit /b 1
)
echo    Serveur et base demarres. Les migrations s'appliquent automatiquement.

REM ---------- 4. Dependances de l'application ----------
echo.
echo --- 4/4  Dependances de l'application ----------------------
pushd frontend
call flutter pub get
if errorlevel 1 (
  echo    [ATTENTION] flutter pub get a echoue.
) else (
  echo    Dependances installees.
)
popd

echo.
echo ============================================================
echo    [OK] PROJET INSTALLE
echo ============================================================
echo.
echo Verifie que le serveur repond :
echo    http://localhost:8001/health
echo.
echo Pour lancer l'application sur ce PC :
echo    cd frontend
echo    flutter run --dart-define=API_BASE_URL=http://localhost:8001/api
echo.
pause

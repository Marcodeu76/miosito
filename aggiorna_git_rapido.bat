@echo off
setlocal

REM === CONFIGURAZIONE (MODIFICA SOLO QUI) ===
SET "PROJECT_DIR=C:\Users\39347\Desktop\miosito"
SET "COMMIT_MSG=Aggiornamento sito"
SET "BRANCH=main"
REM Facoltativo: imposta l'URL del repository GitHub (lascia vuoto se hai gia' origin configurato)
SET "ORIGIN_URL="

echo.
echo Spostamento nella cartella del progetto: "%PROJECT_DIR%"
cd /d "%PROJECT_DIR%"
IF ERRORLEVEL 1 (
  echo ERRORE: percorso non trovato. Controlla PROJECT_DIR nello script.
  pause
  exit /b 1
)

REM Inizializza Git se necessario
IF NOT EXIST ".git" (
  echo Inizializzazione repository Git...
  git init
)

REM Imposta/forza branch
git branch -M %BRANCH% >nul 2>&1

REM Configura origin se manca (o se ORIGIN_URL e' valorizzato)
IF NOT "%ORIGIN_URL%"=="" (
  git remote remove origin >nul 2>&1
  git remote add origin "%ORIGIN_URL%"
)

git remote get-url origin >nul 2>&1
IF ERRORLEVEL 1 (
  echo ERRORE: remote "origin" non configurato.
  echo Apri questo file .bat e compila la variabile ORIGIN_URL con l'URL del tuo repository GitHub.
  echo Esempio: SET "ORIGIN_URL=https://github.com/UTENTE/NOME_REPO.git"
  pause
  exit /b 1
)

echo.
echo Aggiunta file del progetto...
git add .

echo.
echo Creazione commit...
git commit -m "%COMMIT_MSG%" >nul 2>&1
IF ERRORLEVEL 1 (
  echo Nessuna modifica da committare (working tree pulito).
)

echo.
echo Invio al repository GitHub...
REM Prova push normale; se e' il primo push, imposta upstream

git push origin %BRANCH% >nul 2>&1
IF ERRORLEVEL 1 (
  git push -u origin %BRANCH%
) ELSE (
  echo Push completato.
)

echo.
echo Operazione completata.
pause
endlocal

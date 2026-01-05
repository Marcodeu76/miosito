@echo off
setlocal EnableExtensions

REM =====================================================
REM  AGGIORNA GIT RAPIDO
REM  - Lavora SOLO nella cartella PROJECT_DIR
REM  - Usa branch main
REM  - Imposta/aggiorna automaticamente origin con ORIGIN_URL
REM  - Mostra sempre un messaggio finale e attende un tasto
REM =====================================================

REM === CONFIGURAZIONE (MODIFICA SOLO QUI) ===
SET "PROJECT_DIR=C:\Users\39347\Desktop\miosito"
SET "COMMIT_MSG=Aggiornamento sito"
SET "BRANCH=main"
SET "ORIGIN_URL=https://github.com/Marcodeu76/miosito.git"

set "EXITCODE=0"

echo.
echo Spostamento nella cartella del progetto: "%PROJECT_DIR%"
cd /d "%PROJECT_DIR%" || (
  echo.
  echo ERRORE: percorso non trovato. Controlla PROJECT_DIR nello script.
  set "EXITCODE=1"
  goto :END
)

REM Controllo Git
where git >nul 2>&1
if errorlevel 1 (
  echo.
  echo ERRORE: Git non risulta installato o non e' nel PATH.
  echo Suggerimento: installa Git for Windows e riapri questo file.
  set "EXITCODE=1"
  goto :END
)

REM Inizializza Git se necessario
if not exist ".git" (
  echo.
  echo Inizializzazione repository Git...
  git init
  if errorlevel 1 (
    echo ERRORE: git init non riuscito.
    set "EXITCODE=1"
    goto :END
  )
)

echo.
echo Impostazione branch: %BRANCH%
git branch -M %BRANCH% >nul 2>&1

REM Configura origin (sempre) con l'URL indicato
if not "%ORIGIN_URL%"=="" (
  echo.
  echo Configurazione remote origin: %ORIGIN_URL%
  git remote remove origin >nul 2>&1
  git remote add origin "%ORIGIN_URL%"
)

git remote get-url origin >nul 2>&1
if errorlevel 1 (
  echo.
  echo ERRORE: remote "origin" non configurato.
  echo Apri questo file .bat e compila ORIGIN_URL con l'URL del repository GitHub.
  set "EXITCODE=1"
  goto :END
)

echo.
echo Aggiunta file del progetto...
git add .
if errorlevel 1 (
  echo ERRORE: git add non riuscito.
  set "EXITCODE=1"
  goto :END
)

echo.
echo Creazione commit...
git commit -m "%COMMIT_MSG%" >nul 2>&1
if errorlevel 1 (
  echo Nessuna modifica da committare (working tree pulito).
) else (
  echo Commit creato.
)

echo.
echo Invio al repository GitHub...
git push -u origin %BRANCH% >nul 2>&1
if errorlevel 1 (
  echo.
  echo ERRORE: push non riuscito.
  echo Possibili cause: credenziali GitHub, permessi, repository inesistente.
  echo Eseguendo push con output dettagliato...
  git push -u origin %BRANCH%
  set "EXITCODE=1"
  goto :END
)

echo.
echo File aggiornati con successo su GitHub.

:END
echo.
if "%EXITCODE%"=="0" (
  echo Operazione completata.
) else (
  echo Operazione terminata con errori. (codice %EXITCODE%)
)
echo.
pause
endlocal
exit /b %EXITCODE%

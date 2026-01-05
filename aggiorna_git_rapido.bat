@echo off
REM === CONFIGURAZIONE ===
SET PROJECT_DIR=C:\mio sito
SET COMMIT_MSG=Aggiornamento sito
SET BRANCH=main

echo.
echo Spostamento nella cartella del progetto...
cd /d "%PROJECT_DIR%"

IF NOT EXIST ".git" (
    echo Inizializzazione repository Git...
    git init
)

echo Aggiunta file del progetto...
git add .

echo Creazione commit...
git commit -m "%COMMIT_MSG%"

echo Impostazione branch corretto...
git branch -M %BRANCH%

echo Invio al repository GitHub...
git push -u origin %BRANCH%

echo.
echo Operazione completata.
pause

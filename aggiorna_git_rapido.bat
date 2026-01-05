@echo on
echo ==========================================
echo AVVIO AGGIORNAMENTO GIT - MIOSITO
echo ==========================================

cd /d C:\Users\39347\Desktop\miosito

echo.
echo Cartella corrente:
cd

echo.
echo Aggiunta file...
git add .

echo.
echo Creazione commit...
git commit -m "Aggiornamento automatico sito"

echo.
echo Impostazione branch main...
git branch -M main

echo.
echo Impostazione remote origin (se non esiste)...
git remote get-url origin
IF ERRORLEVEL 1 (
    git remote add origin https://github.com/Marcodeu76/miosito.git
)

echo.
echo Invio a GitHub...
git push -u origin main

echo.
echo ==========================================
echo FILE AGGIORNATI CON SUCCESSO
echo Premi un tasto per continuare...
echo ==========================================
pause

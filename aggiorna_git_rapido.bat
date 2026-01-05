@echo on
echo ==========================================
echo AGGIORNAMENTO GIT - MIOSITO
echo ==========================================

cd /d C:\Users\39347\Desktop\miosito

echo.
echo Cartella corrente:
cd

echo.
echo Aggiunta file...
git add .

echo.
echo Verifica modifiche...
git diff --cached --quiet
IF %ERRORLEVEL%==0 (
    echo.
    echo Nessuna modifica da aggiornare.
    goto PUSH
)

for /f "tokens=1-4 delims=/ " %%a in ("%date%") do set DATA=%%d-%%b-%%c
for /f "tokens=1-2 delims=: " %%a in ("%time%") do set ORA=%%a%%b

echo.
echo Creazione commit...
git commit -m "Aggiornamento sito %DATA% %ORA%"

:PUSH
echo.
echo Impostazione branch main...
git branch -M main

echo.
echo Verifica remote origin...
git remote get-url origin
IF ERRORLEVEL 1 (
    git remote add origin https://github.com/Marcodeu76/miosito.git
)

echo.
echo Invio a GitHub...
git push -u origin main

echo.
echo ==========================================
echo OPERAZIONE COMPLETATA CON SUCCESSO
echo Premi un tasto per continuare...
echo ==========================================
pause

@echo off
cd /d "C:\Users\39347\Desktop\miosito"

echo Aggiunta dei file modificati...
git add .

echo Creazione del commit con messaggio predefinito...
git commit -m "Aggiornamento rapido"

echo Invio al repository GitHub...
git push origin master

echo.
echo Aggiornamento completato con successo!
pause

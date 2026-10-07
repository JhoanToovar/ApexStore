@echo off
rem Levanta los nodos en orden 4 -> 3 -> 2 -> 1, cada uno en su ventana. Antes: docker compose up -d y .env listo.
rem Compila todo antes de abrir ventanas: si cada nodo compila a la vez, los modulos compartidos se pisan.
cd /d "%~dp0.."
call gradlew.bat --quiet :nodo1-consola:installDist :nodo2-backend:installDist :nodo3-pasarelas:installDist :nodo4-db:installDist || exit /b 1
cd /d "%~dp0"
start "Nodo 4" cmd /k "%~dp0run-nodo4.bat"
timeout /t 10 /nobreak >nul
start "Nodo 3" cmd /k "%~dp0run-nodo3.bat"
timeout /t 10 /nobreak >nul
start "Nodo 2" cmd /k "%~dp0run-nodo2.bat"
timeout /t 10 /nobreak >nul
start "Nodo 1" cmd /k "%~dp0run-nodo1.bat"

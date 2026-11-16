@echo off
cd /d "%~dp0"
if exist ".venv\Scripts\python.exe" (".venv\Scripts\python.exe" -c "import sys" >nul 2>nul || rmdir /s /q ".venv")
if exist ".venv\Scripts\pythonw.exe" (
  start "" ".venv\Scripts\pythonw.exe" "app\gerador_mapas.pyw"
  exit /b 0
)
rem Sem ambiente ainda: abre com o Python do sistema; o programa se instala sozinho.
where pyw >nul 2>nul && (start "" pyw -3 "app\gerador_mapas.pyw" & exit /b 0)
where pythonw >nul 2>nul && (start "" pythonw "app\gerador_mapas.pyw" & exit /b 0)
echo Python nao encontrado. Rode o INSTALAR.bat primeiro.
pause

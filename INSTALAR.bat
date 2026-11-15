@echo off
cd /d "%~dp0"
if not exist "%~dp0logs" mkdir "%~dp0logs"
set "LOG=%~dp0logs\instalacao_log.txt"
echo ==============================================
echo   Instalador - Gerador de Mapa de Localizacao
echo ==============================================
echo.
set "PY="
py -3.12 -c "import sys" >nul 2>nul && set "PY=py -3.12"
if not defined PY (py -3 -c "import sys" >nul 2>nul && set "PY=py -3")
if not defined PY (python -c "import sys" >nul 2>nul && set "PY=python")
if not defined PY (
  echo Python nao encontrado.
  echo Instale o Python 3.12 em python.org e marque "Add python.exe to PATH".
  echo Depois rode este INSTALAR.bat de novo.
  start https://www.python.org/downloads/windows/
  pause
  exit /b 1
)
echo Usando: %PY%
echo Log da instalacao > "%LOG%"
echo [1/4] Criando ambiente...
if not exist ".venv\Scripts\python.exe" (%PY% -m venv .venv >> "%LOG%" 2>&1 || goto erro)
echo [2/4] Instalando bibliotecas (pode levar alguns minutos)...
".venv\Scripts\python.exe" -m pip install --upgrade pip >> "%LOG%" 2>&1
".venv\Scripts\python.exe" -m pip install -r appequirements.txt >> "%LOG%" 2>&1 || goto erro
echo [3/4] Conferindo instalacao...
".venv\Scripts\python.exe" -c "import geopandas, pyogrio, rasterio, shapely, matplotlib, numpy, requests, contextily, pandas, tkintermapview" >> "%LOG%" 2>&1 || goto erro
echo [4/4] Criando atalho na Area de Trabalho...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$s=(New-Object -ComObject WScript.Shell).CreateShortcut([Environment]::GetFolderPath('Desktop')+'\Gerador de Mapas.lnk');" ^
  "$s.TargetPath='%~dp0.venv\Scripts\pythonw.exe';" ^
  "$s.Arguments='\"%~dp0app\gerador_mapas.pyw\"';" ^
  "$s.WorkingDirectory='%~dp0';" ^
  "$s.Save()"
echo.
echo Pronto! Use o atalho "Gerador de Mapas" na Area de Trabalho
echo (ou de dois cliques em "ABRIR GERADOR.bat").
pause
exit /b 0

:erro
echo.
echo ERRO na instalacao. Ultimas linhas do log (%LOG%):
echo ----------------------------------------------
powershell -NoProfile -Command "Get-Content -Tail 25 -LiteralPath '%LOG%'"
echo ----------------------------------------------
echo Mande um print desta tela para suporte.
pause
exit /b 1

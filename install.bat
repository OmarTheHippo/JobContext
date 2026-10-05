@echo off
rem Job-Context Client installer. Put this file and jobcontext.txt in the same folder
rem (e.g. Documents\JobContext) and double-click this file. No admin rights needed.
cd /d "%~dp0"

if not exist jobcontext.txt (
  echo jobcontext.txt must be in the same folder as install.bat.
  pause
  exit /b 1
)

set "PY="
where py >nul 2>nul && set "PY=py -3"
if not defined PY where python >nul 2>nul && set "PY=python"
if not defined PY (
  echo Python 3 was not found. Install Python 3.9 or newer, then run this again.
  pause
  exit /b 1
)

%PY% -c "import sys; sys.exit(0 if sys.version_info >= (3, 9) else 1)"
if errorlevel 1 (
  echo Python 3.9 or newer is required.
  %PY% --version
  pause
  exit /b 1
)

%PY% jobcontext.txt --install
echo.
pause

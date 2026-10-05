@echo off
rem Job-Context Client installer. Put this file and jobcontext.txt in the same folder
rem (e.g. Documents\JobContext) and double-click this file. No admin rights needed.
cd /d "%~dp0"

if not exist jobcontext.txt (
  echo jobcontext.txt must be in the same folder as install.bat.
  pause
  exit /b 1
)

rem Find a working Python by actually running it. (Checking with "where" isn't reliable,
rem and Windows has a fake "python" that only prints "Python was not found".)
set "PY="
py -c "import sys" >nul 2>nul && set "PY=py"
if not defined PY python -c "import sys" >nul 2>nul && set "PY=python"
if not defined PY python3 -c "import sys" >nul 2>nul && set "PY=python3"
if not defined PY (
  echo Couldn't start Python with "py", "python" or "python3" from this window.
  echo If one of them works in your own terminal, open that terminal in this folder and run:
  echo     py jobcontext.txt --install
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

echo Using: %PY%
%PY% jobcontext.txt --install
echo.
pause

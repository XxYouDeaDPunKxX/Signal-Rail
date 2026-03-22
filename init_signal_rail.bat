@echo off
setlocal

title SIGNAL RAIL BOOTSTRAP
echo SIGNAL RAIL BOOTSTRAP
echo.
echo This launcher starts the bootstrap of a new Signal Rail instance.
echo The real logic lives in init_signal_rail.ps1.
echo.

if not exist "%~dp0init_signal_rail.ps1" (
  echo Missing script: init_signal_rail.ps1
  pause
  exit /b 1
)

set "TARGET_PATH="
set /p TARGET_PATH=Paste the target directory: 
set "TARGET_PATH=%TARGET_PATH:"=%"
if "%TARGET_PATH%"=="" (
  echo.
  echo No directory was entered. Operation cancelled.
  pause
  exit /b 1
)

echo.
set "PROJECT_NAME="
set /p PROJECT_NAME=Host project name ^(optional^): 
set "PROJECT_NAME=%PROJECT_NAME:"=%"

echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0init_signal_rail.ps1" -TargetPath "%TARGET_PATH%" -ProjectName "%PROJECT_NAME%"
set "EXIT_CODE=%ERRORLEVEL%"

echo.
if not "%EXIT_CODE%"=="0" (
  echo Bootstrap not completed. Code: %EXIT_CODE%
) else (
  echo Bootstrap completed.
  echo Recommended next steps:
  echo 1. Read 06_ai_to_ai.txt.
  echo 2. Close host project, working object, and mode.
  echo 3. Fill 01_orientation.txt and 03_master_working.txt first.
  echo 4. Continue from the textual system and use the canonicals by level.
  echo 5. Use 97_field_findings.txt only when you want to keep lateral findings readable before routing or discarding them.
)

pause
exit /b %EXIT_CODE%

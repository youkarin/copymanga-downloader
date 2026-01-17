@echo off
set "VCVARS=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
if not exist "%VCVARS%" (
    echo [ERROR] vcvars64.bat not found at %VCVARS%
    exit /b 1
)

echo [INFO] Setting up MSVC environment...
call "%VCVARS%"

echo [INFO] Manually adding SDK paths to LIB...
set "LIB=%LIB%;C:\Program Files (x86)\Windows Kits\10\Lib\10.0.19041.0\um\x64;C:\Program Files (x86)\Windows Kits\10\Lib\10.0.19041.0\ucrt\x64"

echo [INFO] Debug: LIB is %LIB%

echo [INFO] Augmenting PATH for Cargo...
set "PATH=%PATH%;%USERPROFILE%\.cargo\bin"

echo [INFO] Starting Tauri build...
pnpm tauri build > final_build_log_v5.txt 2>&1

if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Build failed! Last 100 lines of log:
    powershell -Command "Get-Content final_build_log_v5.txt -Tail 100"
    exit /b 1
)
echo [SUCCESS] Build completed!

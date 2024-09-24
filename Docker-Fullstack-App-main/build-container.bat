@echo off
docker info >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Docker Desktop is not running. Please start Docker Desktop.
    echo Press any key to exit...
    pause >nul
    exit /b 1
) else (
    echo Docker Desktop is running. Proceeding with the build...
	docker build -t my-fullstack-app .
	echo Finished
    echo Press any key to exit...
    pause >nul	
)

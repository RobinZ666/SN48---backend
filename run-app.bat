@echo off
echo Starting AI Classroom Backend Application...
echo.

echo Step 1: Starting PostgreSQL database...
docker-compose up -d
if %errorlevel% neq 0 (
    echo Warning: Could not start PostgreSQL via Docker. Make sure Docker is installed and running.
    echo If you have PostgreSQL running locally, you can continue.
    pause
)

echo.
echo Step 2: Waiting for database to be ready...
timeout /t 10 /nobreak

echo.
echo Step 3: Building and running the application...
mvn clean compile
if %errorlevel% neq 0 (
    echo Build failed. Please check your Java version (requires Java 17 or higher).
    pause
    exit /b 1
)

echo.
echo Step 4: Starting the application...
mvn spring-boot:run

echo.
echo Application stopped.
pause
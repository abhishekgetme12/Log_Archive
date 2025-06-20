@echo off
REM ---------------------------------------------------------------------------
REM This batch script automates log backup and service management tasks.
REM 
REM Main Script (Log_archive.bat):
REM - Reads a list of IP addresses from IP_List.txt.
REM - For each IP, calls Log_archive.bat with the IP as an argument.
REM - Exits after processing all IPs.
REM
REM Log_archive.bat:
REM - Stops a specified service on the target machine.
REM - Renames the backup log folder with the current date and time.
REM - Creates a new empty folder for logs.
REM - Starts the service again.
REM - Logs all actions to a daily log file in the Logs directory.
REM
REM Inline Documentation:
REM - The 'for /F' loop reads each line (IP address) from IP_List.txt and calls Log_archive.bat.
REM - The 'exit' command terminates the main script after processing.
REM - The '@echo off' command suppresses command echoing for cleaner output.
REM - Date and time are parsed and formatted for use in log file naming.
REM - The script checks for the existence of the Logs directory and creates it if missing.
REM - Log files are named by date; if a log exists, it appends a message, otherwise it creates a new log.
REM - The IP address argument is captured for use in service management commands.
REM - Service management commands (stop, rename, create, start) are to be added where indicated.
REM
REM Note: Replace placeholder service management commands with actual implementation as needed.
REM ---------------------------------------------------------------------------

REM Get date and time components
for /f "tokens=2-4 delims=/ " %%g in ('date /t') do (
    set mm=%%g
    set dd=%%h
    set yy=%%i
)
set Today=%date:~-4%-%date:~4,2%-%date:~7,2%
set Now=%time:~0,2%-%time:~3,2%-%time:~6,2%

REM Create Logs directory if it doesn't exist
if not exist .\Logs mkdir .\Logs
cls

REM Log start or existence
if exist .\Logs\Log-%Today%.log (
    echo %Today%-%Now% == Log-%Today%.log already EXIST >> .\Logs\Log-%Today%.log
) else (
    echo %Today%-%Now% == Tool Execution Started at Location : %CD% > .\Logs\Log-%Today%.log
)

set ip_address=%~1

REM ##Add your service name here
REM set service_name="YourServiceName"

set folder_creation=\\%ip_address%\c$\YourServiceName\   # Path to the folder where logs will be copied
set log_Destination=\\c$\Files\%mm%-%yy%\%mm%%dd%-%yy%\%ip_address%\Log\ # Destination path for the logs
set Dest_folder=\\%ip_address%\c$\YourServiceName\Logs # Path to the folder where logs will be copied

echo ----------------------------- %ip_address% --------------------------------- >> .\Logs\Log-%Today%.log
echo ----------------------------- YourServiceName --------------------------------- >> .\Logs\Log-%Today%.log

if exist %folder_creation% (
    REM move /y %Move_logs% %log_Destination%
    xcopy %Dest_folder% %log_Destination% /e/i/c/q/y
    timeout /t 3 >nul

    if %ERRORLEVEL% EQU 0 (
        echo %mm%-%dd%-%yy%#%time%  service_name: %service_name% / IP_Address: %ip_address% Folder copied successfully :OK >> .\Logs\Log-%Today%.log
    ) else (
        echo %mm%-%dd%-%yy%#%time%  service_name: %service_name% / IP_Address: %ip_address% Error while copying folder :OK >> .\Logs\Log-%Today%.log
    )
)

echo -----------------------------------END-------------------------------------- >> .\Logs\Log-%Today%.log

pushd \\%ip_address%\c$

echo ---------------------------------------- YourServiceName --------------------------------- >> .\Logs\Log-%Today%.log

if exist .\YourServiceName\ (
    echo Logs deletion is in progress for YourServiceName : >> .\Logs\Log-%Today%.log
    ForFiles /p ".\YourServiceName\Logs" /d -1 /c "cmd /c del @file"
    timeout /t 3 >nul
    echo Logs deletion is Completed for YourServiceName : >> .\Logs\Log-%Today%.log
) else (
    echo folder does not exist, check manually in server : >> .\Logs\Log-%Today%.log
    timeout /t 5 >nul
)

popd

echo -----------------------------------END-------------------------------------- >> .\Logs\Log-%Today%.log
echo %mm%-%dd%-%yy%#%time%  service_name: %service_name% / IP_Address: %ip_address% Log archive completed >> .\Logs\Log-%Today%.log
echo ----------------------------- %ip_address% --------------------------------- >> .\Logs\Log-%Today%.log

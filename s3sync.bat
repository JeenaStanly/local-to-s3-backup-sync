@echo off
:: Set AWS S3 bucket name
set BUCKET_NAME=s3://[Bucket_name] --region us-east-1

:: Set local directory to sync
set LOCAL_DIR=C:\[Path_to_your_directory]

:: Set log file path (using timestamped logs)
set LOG_DIR=C:\logs\s3synclogs
set LOG_FILE=%LOG_DIR%\s3sync_%DATE:~-10,2%-%DATE:~-7,2%-%DATE:~-4,4%.log


:: Ensure the logs directory exists
if not exist %LOG_DIR% mkdir %LOG_DIR%

:: Perform S3 Sync with optimizations
aws s3 sync %LOCAL_DIR% %BUCKET_NAME% --delete --exclude "*" --include "*.csv" --exclude "*.docx" --exclude "*.png" --exclude "*.ini" >> %LOG_FILE% 2>&1

:: Upload the log file to S3 for monitoring
aws s3 cp %LOG_FILE% s3://logs-for-s3-sync/logs/

:: Optional: Cleanup old logs (delete logs older than 7 days)
forfiles /p %LOG_DIR% /s /m s3sync_*.log /d -7 /c "cmd /c del @file"

@echo Sync completed! Logs saved at %LOG_FILE%

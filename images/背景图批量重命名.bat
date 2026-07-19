@echo off
chcp 65001 >nul
title Background Batch Rename Tool

:: Switch to background subfolder
cd /d "%~dp0\background"
if errorlevel 1 (
    pause
    exit /b
)

setlocal enabledelayedexpansion
set tmpCount=0
set success=0
set fail=0

:: Step1: Temp rename all images to avoid duplicate name error, hide all output
for /f "delims=" %%i in ('dir /b *.jpg *.jpeg *.png *.webp *.bmp *.tiff 2^>nul') do (
    ren "%%i" "tmp_%%~ni%%~xi" >nul 2>&1
)

:: Step2: Rename temp files to bg_xx.jpg, suppress error output
for /f "delims=" %%i in ('dir /b tmp_*.* 2^>nul') do (
    ren "%%i" "bg_!tmpCount!.jpg" >nul 2>&1
    if !errorlevel! equ 0 (
        set /a success+=1
    ) else (
        set /a fail+=1
    )
    set /a tmpCount+=1
)

:: Final summary only
echo ==============================================
echo Result: SUCCESS
echo Total renamed successfully: !success!
echo Total failed files: !fail!
echo ==============================================
pause
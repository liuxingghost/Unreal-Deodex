@echo off
title Unreal Deodex (GET INLINE)

title deodex tools
color 0c

:: Unreal Deodex - Get_Inline
:: Version 	: 1.5
:: Autor	: UnrealMitch <UnrealMitch@gmail.com>

echo *******************************************************************************
echo *                                                                             *
echo *                           Unreal Deodex (MTK 6592)                          *
echo *                                                                             *
echo *                                                      Created by UnrealMitch *
echo *******************************************************************************
echo.

echo -Backup last inline
for /f %%i in ('dir /b *.txt') do ( ren %%i bak_%%i )
echo -Starting adb
echo.
adb\adb kill-server
adb\adb start-server
echo.
echo -Connect the device
adb\adb wait-for-device
echo.
echo -Getting the files
adb\adb push deodexerant /data/local/tmp/
adb\adb shell chmod 755 /data/local/tmp/deodexerant
echo.
echo -Generating inline.txt
adb\adb shell /data/local/tmp/deodexerant > inline.txt
echo.
echo -Sucesfull
pause

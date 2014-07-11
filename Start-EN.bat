@ECHO off

title Unreal Deodex
color 0a

:: Unreal Deodex 
:: Version 	: 2.0
:: Autor	: UnrealMitch <UnrealMitch@gmail.com>

CLS

echo *******************************************************************************
echo *                                                                             *
echo *                           Unreal Deodex (MTK 6592)                          *
echo *                                                                             *
echo * EN                                                   Created by UnrealMitch *
echo *******************************************************************************
echo.

if not exist tools (
echo #Error:  Not found the folder \tools
pause
exit )

echo #This program will take the following actions to deodex this ROM:
echo.
echo -Copy the device files /system/app and /system/framework (adb)
echo -Get the table inline davlik of your device (adb)
echo -Deodex framework and apps
echo.
echo.
echo #The steps are:
echo.
echo -Enable USB debugging on your device settings
echo -Having adb drivers on your system
echo Connect your phone to your computer via USB, and the ROM to deodex
echo -Press continue and NOT DISCONNECT the phone until instructed
echo -Wait for it to finish deodexar all files (have coffee)
echo -The end result will be in /system
echo.
SET /P NULL=Pulse enter to start!

if exist system (
	if exist system_bak rd /q /s system_bak
	mkdir system_bak
	xcopy system system_bak /E/Q >nul
	rd /q /s system
	mkdir system
	mkdir system\app
	mkdir system\framework
)



CLS

echo *******************************************************************************
echo *                                                                             *
echo *                           Unreal Deodex (MTK 6592)                          *
echo *                                                                             *
echo * ES                                                   Created by UnrealMitch *
echo *******************************************************************************
echo.

SET /P NULL=-Connect your device to your computer via usb and press ENTER

echo.
echo -Starting adb
echo.
tools\adb\adb kill-server
tools\adb\adb start-server
echo.
echo -Connect your device
tools\adb\adb wait-for-device
echo.

echo -Dumping FRAMEWORK ...
echo.
tools\adb\adb pull /system/framework/ system/framework/
echo.
echo -Dumping APPS ...
echo.
tools\adb\adb pull /system/app/ system/app/
echo.

echo -Get INLINE of your device
echo.
cd tools
for /f %%i in ('dir /b *.txt') do ( ren %%i bak_%%i )
cd ..
tools\adb\adb push tools/deodexerant /data/local/tmp/
tools\adb\adb shell chmod 755 /data/local/tmp/deodexerant
tools\adb\adb shell /data/local/tmp/deodexerant > tools/inline.txt
tools\adb\adb kill-server
echo.
echo --Dump data over, u already can disconnect your device
echo.
SET /P NULL=Pulse ENTER to start deodex

DEODEX



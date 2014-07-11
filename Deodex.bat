@ECHO off

title Unreal Deodex
color 0c

:: Unreal Deodex 
:: Version 	: 2.0
:: Autor	: UnrealMitch <UnrealMitch@gmail.com>

CLS

echo *******************************************************************************
echo *                                                                             *
echo *                           Unreal Deodex (MTK 6592)                          *
echo *                                                                             *
echo *                                                      Created by UnrealMitch *
echo *******************************************************************************
echo.

              
if not exist system\app (
echo #Error: System can't found \ app
pause
exit )
if not exist system\framework (
echo #Error:  System can't found \ framework
pause
exit )
if not exist tools (
echo #Error:  System can't found the tools directory
pause
exit )

set /A API=17
echo.
echo.
echo -- Please, enter number of android API you want to use (default 17):
echo.
echo    19 : Android 4.4 	(KitKat)
echo    18 : Android 4.3 	(Jelly Bean)
echo    17 : Android 4.2 	(Jelly Bean) 	also 4.2.2
echo    16 : Android 4.1 	(Jelly Bean) 	also 4.1.1
echo    15 : Android 4.0.3 	(Ice Cream) 	also 4.0.4
echo    14 : Android 4.0 	(Ice Cream) 	also 4.0.1, 4.0.2
echo    13 : Android 3.2 	(HoneyComb) 	
echo    12 : Android 3.1.x 	(HoneyComb) 	
echo    11 : Android 3.0.x 	(HoneyComb) 	
echo    10 : Android 2.3.3 	(GingerBread) 	also 2.3.4
echo    9  : Android 2.3 	(GingerBread) 	also 2.3.1, 2.3.2
echo    8  : Android 2.2.x 	(Froyo) 	
echo.
set /P API="API Version : "
echo API Selected: %API% 
echo.

echo -Creating Backup to workspace
if exist system\temp_framework rd /q /s system\temp_framework
mkdir system\temp_framework
xcopy system\framework system\temp_framework /E/Q >nul
echo.
echo -Backup successful
echo.

echo --Starting to deodex framework
echo.
set/a numdeox = 1
set totala= 0
for %%i in (baksmali.jar smali.jar 7z.exe 7z.dll) do copy tools\%%i system\framework\ >nul
for /r system\framework\ %%a in (*.odex) DO (Set /A total+= 1)
for /r system\framework\ %%a in (*.odex) do call :deodex %%a jar
echo -Deodex framework sucesfull
for %%i in (baksmali.jar smali.jar 7z.exe 7z.dll) do del /f system\framework\%%i 
echo.

echo --Starting to deodex apps
echo.
set/a numdeoxa = 1
set totala = 0
for %%i in (baksmali.jar smali.jar 7z.exe 7z.dll) do copy tools\%%i system\app\ >nul
for /r system\app\ %%a in (*.odex) do (Set /A totala+= 1)
for /r system\app\ %%a in (*.odex) do call :deodex %%a apk
echo -Deodex apps sucesfull
for %%i in (baksmali.jar smali.jar 7z.exe 7z.dll) do del /f system\app\%%i 
echo.

echo -Delete BackUp
rd /q /s system\temp_framework
echo.
echo --FINISH!
echo.
pause
goto :eof

:deodex

if %2 equ jar (
cd system\framework
) else if %2 equ apk (
cd system\app
) else (
echo #ERROR 2 : System\app not found
pause
goto :eof
)                                                           

if %2 equ jar (
set/a numdeox += 1
echo ---- [FW: %numdeox% of %total%] Deodex %~n1.%2 ----
) else if %2 equ apk (
set/a numdeoxa += 1
echo ---- [APP: %numdeoxa% of %totala%] Deodex %~n1.%2 ----
)

echo -Convert %~n1.odex to classes.dex ...
java -jar baksmali.jar -a %API% -T ../../tools/inline.txt -d ../temp_framework -x %1
java -jar smali.jar -a %API% out -o classes.dex

del %1 /Q
rd out /Q /S
echo -Merge %~n1.%2 and classes.dex ...
7z.exe a -tzip %~n1.%2 classes.dex>nul
del classes.dex /Q
cd ..\..\
echo ---- Deodex %~n1.%2 successfull ----
echo.
goto :eof

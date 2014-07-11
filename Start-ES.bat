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
echo * ES                                                   Created by UnrealMitch *
echo *******************************************************************************
echo.

if not exist tools (
echo #Error:  No se ha encontrado la carpeta \tools
pause
exit )

echo #Este programa va realizar las siguientes acciones para deodexar la ROM:
echo.
echo -Copiar del dispositivo las carpetas /system/app y /system/framework (adb)
echo -Obtener la table inline de davlik de tu dispositivo (adb)
echo -Deodexar tanto el framework como las apps
echo.
echo.
echo #Los pasos a seguir son los siguientes:
echo.
echo -Activar la Depuracion USB en la configuracion de tu dispositivo
echo -Tener los drivers de adb en tu sistema
echo -Conectar el movil al ordenador via USB, encendido y en la rom a deodexar
echo -Pulsar continuar y NO DESCONECTAR el movil hasta que se indique
echo -Esperar a que termine de deodexar todos los archivos (tarda un ratillo)
echo -El resultado final estara en /system
echo.
SET /P NULL=Pulsa enter para comenzar!

if exist system (
	if exist system_bak rd /q /s system_bak
	mkdir system_bak
	xcopy system system_bak /E/Q >nul
	rd /q /s system
	mkdir system
)
	mkdir system\app
	mkdir system\framework

CLS

echo *******************************************************************************
echo *                                                                             *
echo *                           Unreal Deodex (MTK 6592)                          *
echo *                                                                             *
echo * ES                                                   Created by UnrealMitch *
echo *******************************************************************************
echo.

SET /P NULL=-Conecta tu dispositivo al ordenador via usb y pulse ENTER

echo.
echo -Iniciando adb
echo.
tools\adb\adb kill-server
tools\adb\adb start-server
echo.
echo -Conectando a dispositivo
tools\adb\adb wait-for-device
echo.

echo -Volcando FRAMEWORK ...
echo.
tools\adb\adb pull /system/framework/ system/framework/
echo.
echo -Volcando APPS ...
echo.
tools\adb\adb pull /system/app/ system/app/
echo.

echo -Obteniendo inline de tu dispositivo
echo.
cd tools
for /f %%i in ('dir /b *.txt') do ( ren %%i bak_%%i )
cd ..
tools\adb\adb push tools/deodexerant /data/local/tmp/
tools\adb\adb shell chmod 755 /data/local/tmp/deodexerant
tools\adb\adb shell /data/local/tmp/deodexerant > tools/inline.txt
tools\adb\adb kill-server
echo.
echo --Volcado de datos terminado, ya puede desconectar su dispositivo
echo.
SET /P NULL=Pulsa enter para empezar a deodexar

DEODEX



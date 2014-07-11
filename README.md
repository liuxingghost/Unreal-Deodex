UNREAL-DEODEX
=========

Unreal deodex is a script (in .bat) for Windows, that it can deodex apps and framework of Android ROM. It also can get these folders (app and fw) of the Phone.

Functions of Script:
  - Get /system/app/* /system/framework of the phone
  - Get specific inline of the phone
  - Can change Android API to deodex
  - Deodex APPs and FrameWork

Versions
--------------

1.5

First complete functional script

2.0

Add support to change ANDROID API

USE
--------------

```
-If you want deodex some rom without files of it: 

You only need execute STAR EN and follow the intructions of the program (you will get files from the phone).


-If u already have folders /system/app and /system/framework of your device:

Copy these folders into /system of this script (delete previous app and framdework):
	-Run Deodex
	*If this script throws this error "RegCount" when deodex some app:
		-Run tools/get_inline previous run Deodex
		-Delete previous /system/app and /system/framework in "Unreal-Deodex"
		-Copy again yours app and framework in /system
		-Run Deodex

```


License
----

OPENSOURCE

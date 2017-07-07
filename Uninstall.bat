@ECHO OFF
SETLOCAL EnableDelayedExpansion
CD /D %~dp0
SET "defaultbk=bkdefault.reg"
SET "currbk=%defaultbk%"
SET "scriptspath=C:\Scripts"
SET "scriptname=dcminfo"
SET "scriptpath=%scriptspath%\%scriptname%"
SET "regbk=%scriptpath%\bk.reg"

IF NOT EXIST "%regbk%" (GOTO NOBAK) ELSE (SET "currbk=%regbk%" & GOTO IMPORT)


:NOBAK
ECHO %regbk% registry backup that is generated with AddContext.bat does not exist. Do you want to use the default registry backup? Warning: This may cause system instability, please carefully view the keys affected by %defaultbk% before proceeding.

SET usrinput= 
SET /P usrinput="(Y/N): "

IF /I !usrinput!==Y (SET "currbk=%defaultbk%" & GOTO IMPORT) ELSE (ECHO Nothing done. Exiting... & GOTO END)


:IMPORT
ECHO Using %currbk%...

ECHO Deleting HKCR\ClearCanvas.ImageViewer\shell\View Metadata

REG DELETE "HKCR\ClearCanvas.ImageViewer\shell\View Metadata" /f >nul 2>&1

ECHO Deleting HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dcm

REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dcm" /f >nul 2>&1

ECHO Importing backup from %currbk%

REG IMPORT "!currbk!" >nul 2>&1

ECHO Done


:END
RMDIR /S /Q %scriptpath% >nul 2>&1
ENDLOCAL
PAUSE
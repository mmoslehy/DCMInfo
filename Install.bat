@ECHO OFF
CD /D %~dp0
SET "scriptname=dcminfo"
SET "scriptpath=C:\Scripts\%scriptname%"
SET "exename=dcminfo.exe"
SET "rgbk=%scriptpath%\bk.reg" >nul 2>&1
SET "tmpfile=%temp%\temp.reg"
SET "regimport=%TEMP%\clearcanvasprogid.reg" >nul 2>&1

:: Main ::
MKDIR %scriptpath% >nul 2>&1
COPY *.bat %scriptpath% >nul 2>&1
GOTO BKREG
::

:BKREG
ECHO;
ECHO Backing up registry...
REG QUERY "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dcm" >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
	REG EXPORT "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dcm" "%rgbk%.tmp" /y >nul 2>&1
	::Convert Unicode encoding to ANSI
	TYPE "%rgbk%.tmp" > "%rgbk%"
	DEL "%rgbk%.tmp"
	) ELSE (
		ECHO Windows Registry Editor Version 5.00 >> %rgbk%
		ECHO [-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dcm] >> %rgbk%
	)
REG QUERY "HKEY_CLASSES_ROOT\ClearCanvas.ImageViewer" >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
	REG EXPORT "HKEY_CLASSES_ROOT\ClearCanvas.ImageViewer\shell\View Metadata\command" "%tmpfile%" /y >nul 2>&1
	TYPE %tmpfile% | FINDSTR /V "Windows^ Registry^ Editor^ Version^ 5.00" >> %rgbk%
	) ELSE (
		ECHO [-HKEY_CLASSES_ROOT\ClearCanvas.ImageViewer] >> %rgbk%
	)
ECHO Successfully backed up registry to %rgbk%.
GOTO IMPORTREG


:IMPORTREG
ECHO;
ECHO Editing registry...

:: Add key to associate contexts with the new/existing ClearCanvas key
REG ADD "HKEY_CLASSES_ROOT\ClearCanvas.ImageViewer\shell\View Metadata\command" /ve /d "%scriptpath%\%exename% %%1" /f >nul 2>&1
IF %ERRORLEVEL% EQU 0 (ECHO Successfully added HKEY_CLASSES_ROOT\ClearCanvas.ImageViewer\shell\View Metadata\command)

:: Add key to associate the ClearCanvas key to the .dcm extension
(
	echo Windows Registry Editor Version 5.00
	echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dcm\OpenWithProgids]
	echo "ClearCanvas.ImageViewer"=hex^(0^):

) > "%regimport%"
REG IMPORT %regimport% >nul 2>&1
IF %ERRORLEVEL% EQU 0 (ECHO Successfully edited HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.dcm\OpenWithProgids)
REM Delete the temporary file
DEL %regimport% >nul 2>&1

:: Copy the executable script to a local directory
ECHO Copying the script to %scriptpath%...
TIMEOUT /NOBREAK /T 2 >nul 2>&1
XCOPY /I /G /Q /H /Y "bin" "%scriptpath%" >nul 2>&1
IF %ERRORLEVEL% EQU 0 (ECHO Successfully copied into %scriptpath%.)

GOTO END

:END
PAUSE
# Small script written in python and made into an executable with pyinstaller
#### It allows you to write click any .dcm file and view its metadata using your default text editor.

## Installation instructions:

- Download the package
- Run Install.bat as Administrator


## Uninstallation instructions:

- Run C:\Scripts\dcminfo\Uninstall.bat as Administrator


## Building instructions:
1. [Install Python 2.7](https://www.python.org/ftp/python/2.7.13/python-2.7.13.msi) (make sure you check "add Python to PATH")
2. [Install Git bash](https://git-scm.com/downloads)
3. Open Git Bash as Administrator and run the following commands:
```
	1. git clone https://github.com/moselhy/DCMInfo
	2. pip install pyinstaller pydicom
	3. cd DCMInfo/src
	4. pyinstaller dcminfo.py -i icon.ico --onefile
	5. cp -f dist/dcminfo.exe ../bin
	6. ../Install.bat
```


## Screenshot:


![Alt text](dcminfo.png?raw=true "Screenshot")

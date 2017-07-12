Small script written in python and made into an executable with py2exe.
It allows you to write click any .dcm file and view its metadata using your default text editor.

Installation instructions:

- Download the package
- Run Install.bat as Administrator


Uninstallation instructions:

- Run C:\Scripts\dcminfo\Uninstall.bat as Administrator


Building instructions:
- Run the following commands:
- [Install python](https://www.python.org/)
- [Install Git bash](https://git-scm.com/downloads)
- Open Git Bash and run the following commands:
```
	1) git clone https://github.com/mmoslehy/DCMInfo
	2) pip install pyinstaller
	3) cd DCMInfo/src
	4) pyinstaller dcminfo.py -i icon.ico
```


Screenshot: <br />


![Alt text](dcminfo.png?raw=true "Screenshot")
<!-- ![ScreenShot](dcminfo.png?raw=true) -->

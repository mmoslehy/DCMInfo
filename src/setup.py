from distutils.core import setup
import py2exe

setup(
	console = [
		{
			"script": 'dcminfo.py',
			"icon_resources": [(42, "icon.ico")]
		}
	]
)

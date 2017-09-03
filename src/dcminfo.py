import dicom, subprocess, sys, os
from tempfile import NamedTemporaryFile

if len(sys.argv) < 2:
  print("No input detected, usage: %s [file]" % sys.argv[0])
  sys.exit(2)
filepath = sys.argv[1]
ds = dicom.read_file(filepath)
filename = os.path.splitext(os.path.basename(filepath))[0]
f = NamedTemporaryFile(prefix=filename+'.tmp', suffix='.txt', delete=False)
f.write(str(ds))
f.close()

if sys.platform.startswith('linux'):
	subprocess.Popen('xdg-open ' + f.name, shell=True)

elif sys.platform == 'win32':
	subprocess.Popen('start ' + f.name, shell=True)

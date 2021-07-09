import sys
from onvif import ONVIFCamera
 
if len(sys.argv) < 4:
    user = ''
else:
    user = sys.argv[3]
 
if len(sys.argv) < 5:
    password = ''
else:
    password = sys.argv[4]      
 
mycam = ONVIFCamera(sys.argv[1], sys.argv[2], user, password, '/usr/local/lib/python3.9/site-packages/wsdl/')
 
resp = mycam.devicemgmt.GetDeviceInformation()
print (str(resp))
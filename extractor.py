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
 
resp = mycam.devicemgmt.GetNetworkInterfaces()
print (str(resp))
 
media_service = mycam.create_media_service()
profiles = media_service.GetProfiles()
token = profiles[0].token
 
mycam = media_service.create_type('GetStreamUri')
mycam.ProfileToken = token
mycam.StreamSetup = {'Stream': 'RTP-Unicast', 'Transport': {'Protocol': 'RTSP'}}
print(media_service.GetStreamUri(mycam))
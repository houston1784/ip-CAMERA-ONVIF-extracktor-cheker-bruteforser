#!/bin/bash
 
line=$1
 
GetCapabilities=`cat <<_EOF_
    <s:Envelope
        xmlns:s="http://www.w3.org/2003/05/soap-envelope">
        <s:Body
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema">
            <GetCapabilities
                xmlns="http://www.onvif.org/ver10/device/wsdl">
                <Category>
                    All
                    </Category>
                </GetCapabilities>
            </s:Body>
        </s:Envelope>
_EOF_`
 
result=`timeout 5 curl -s $line:8899/onvif/device_service -d "$GetCapabilities" | grep -i -E 'GetCapabilitiesResponse' | xmllint --format - 2>/dev/null | grep -i -E -v 'parser error'`; 
result2=`timeout 5 curl -s $line:80/onvif/device_service -d "$GetCapabilities" | grep -i -E 'GetCapabilitiesResponse' | xmllint --format - 2>/dev/null | grep -i -E -v 'parser error'`; 
result3=`timeout 5 curl -s $line:8080/onvif/device_service -d "$GetCapabilities" | grep -i -E 'GetCapabilitiesResponse' | xmllint --format - 2>/dev/null | grep -i -E -v 'parser error'`; 
result4=`timeout 5 curl -s $line:5000/onvif/device_service -d "$GetCapabilities" | grep -i -E 'GetCapabilitiesResponse' | xmllint --format - 2>/dev/null | grep -i -E -v 'parser error'`; 
result5=`timeout 5 curl -s $line:6688/onvif/device_service -d "$GetCapabilities" | grep -i -E 'GetCapabilitiesResponse' | xmllint --format - 2>/dev/null | grep -i -E -v 'parser error'`; 
 
if [ "$result" ]; then
    echo "Found: $line:8899";
    response=`python extractor.py $line 8899 2>/dev/null | sed -E "s/\/\/.+:/\/\/$line:/"`
    if [ "$response" ]; then
        echo "$response" > results/$line.txt
    fi
fi
 
if [ "$result2" ]; then
    echo "Found: $line:80";
    response=`python extractor.py $line 80 2>/dev/null | sed -E "s/\/\/.+:/\/\/$line:/"`
    if [ "$response" ]; then
        echo "$response" > results/$line.txt
    fi
fi
 
if [ "$result3" ]; then
    echo "Found: $line:8080";
    response=`python extractor.py $line 8080 2>/dev/null | sed -E "s/\/\/.+:/\/\/$line:/"`
    if [ "$response" ]; then
        echo "$response" > results/$line.txt
    fi
fi
     
if [ "$result4" ]; then
    echo "Found: $line:5000";
    response=`python extractor.py $line 5000 2>/dev/null | sed -E "s/\/\/.+:/\/\/$line:/"`
    if [ "$response" ]; then
        echo "$response" > results/$line.txt
    fi
fi
 
if [ "$result5" ]; then
    echo "Found: $line:6688";
    response=`python extractor.py $line 6688 2>/dev/null | sed -E "s/\/\/.+:/\/\/$line:/"`
    if [ "$response" ]; then
        echo "$response" > results/$line.txt
    fi
fi
# teamengine-integration-testing
Code and instructions to test teamengine on the web, integrating some ETS and sample files

CSW Test.jmx : Contain jmeter script for testing CSW2.0.2 test.<br/>
GML Test.jmx : Contain jmeter script for testing GML3.2.1 test.<br/>
KML Test.jmx : Contain jmeter script for testing KML2.2 test.<br/>
SOS Test.jmx : Contain jmeter script for testing SOS1.0.0 test.<br/>
WFS1.1.0_Test.jmx : Contain jmeter script for testing WFS1.1.0 test. In this user set **Supported conformance classes** and **GML Simple Features (GMLSF) compliance level** inside test parameter config element.<br/>
WFS2.0_Test.jmx : Contain jmeter script for testing WFS2.0 test. In this user set **Feature identifier** inside Feature identifier config element.<br/>
WMS1.3.0_Test.jmx : Contain jmeter script for testing WMS1.3.0 test. In this user set all other parameter inside test parameter config element.<br/>
filePath.csv : This file contains the xml file path which user wish to test.<br/>
user.csv : This file user's login credential info.

**Note:** 1. Set the file path of "user.csv" inside "userLoginData" config file.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. Set the file path of "filePath.csv" inside "filePathData" config file. 

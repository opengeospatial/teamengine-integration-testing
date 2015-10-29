# teamengine-integration-testing
Code and instructions to test teamengine on the web, integrating some ETS and sample files <br/>

# Test Suites that can be tested

- CSW 2.0.2
- CAT 3.0
- GML 3.2.1
- SOS 1.0.0
- WCS 2.0
- WFS 1.0
- WFS 1.1
- WFS 2.0
- WMS 1.1.1
- WMS 1.3

Reference Implementations here:
https://github.com/opengeospatial/cite/wiki/Reference-Implementations


* **Specified Key**<br/>

 - -f&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:	path of jmeter script<br/>
 - -u&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:	path of URL<br/>
 - -user&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:	User name<br/>
 - -password&nbsp;:	User password<br/>


* **EXAMPLE**<br/>
1. sh ./shellscript.sh  -user username -password paswordOfUser -f pathOfAllJmetersFile -u pathOfTeamengineURL

* file.csv : This file contains the xml file path which user wish to test.<br/>


## Target platforms

### GNU/Linux
* __OS__: ?
* __JDK__: Oracle JDK 7u79
* __Web container__: Apache Tomcat 7.0.6n

### Windows
* __OS__: ?
* __JDK__: Oracle JDK 7u79
* __Web container__: Apache Tomcat 7.0.6n

### OS X
* __OS__: ?
* __JDK__: Oracle JDK 7u79
* __Web container__: Apache Tomcat 7.0.6n

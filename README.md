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

# **EXAMPLE:**<br/>
1. sh ./shellscript.sh  -user username -password paswordOfUser -f pathOfAllJmetersFile -u pathOfTeamengineURL
   
   e.g. sh ./shellscript.sh -user admin -password admin123 -u http://localhost:8080/teamengine/ -f ~/repo/teamengine-integration-testing/
 
* file.csv : This file contains the xml or sch file path and revision number which user wish to test.<br/>


# **Note:**<br/>
1.[Option -f :-  If you does not provide the path of jmeter script then it will take the default "Current Working Directroy (pwd)" path ]<br/>
2.[If you are not providing the Username and password then it will take the default 'Username:ogctest', 'Password:ogctest' will be used] <br/>

* **Before executing the Testing script please check the revision number of test suite which is currently present in teamengine.** 

The default value is present in the CSV file, if you want to change the reference url and revision specified in the CSV files please use follwoing steps:

* csw202:
	In this we have to specify reference implementation URL and revision number which is present in teamengine.
	First parameter is 'reference url',second 'revision (e.g. 1.15-SNAPSHOT)'. 

* gml32:
	In this we have to specify reference implementation URL and revision number which is present in teamengine.
	First parameter is 'reference url',second 'revision (e.g. 1.22)'.

* gml32-doc:
	In this we have to specify the GML resource file name which should present in gml32-doc directory and revision number which is present in teamengine.
	First parameter is 'GML resource file name',second 'revision (e.g. 1.22)'.

* sos10:
	In this we have to specify reference implementation URL and revision number which is present in teamengine. 
	First parameter is 'reference url',second 'revision (e.g. 1.13)'.

* wms13:
	In this we have to specify reference implementation URL and revision number which is present in teamengine.
	First parameter is 'reference url',second 'revision (e.g. 1.15-SNAPSHOT)'.

* gml32-GET:
	As similar to above.
	First parameter is 'reference url',second 'revision (e.g. 1.12)'.

* gml32-POST:
	In this we have to specify the GML resource file name and schematron file name which should present in gml32-POST directory and revision number which is present in teamengine.
	First parameter is 'GML resource file name',second schematron file name', third 'revision (e.g. 1.22)'.


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

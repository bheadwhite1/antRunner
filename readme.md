Search the project for "techuserDir" and replace the path with your local 44 path
this project utilizes a few command line tools: apache ant, xmlTidy, xmlStarlet.

SET UP APACHE ANT:
grab a binary:
https://ant.apache.org/bindownload.cgi

set a system environment called ANT_HOME and have it point to your ant bin.

-to set java properties: 
create a file in your home directory called "antrc_pre.bat"

mine looks like this:
@echo off
SET "ANT_OPTS=-DentityExpansionLimit=100000"


SET UP XMLTIDY:
http://binaries.html-tidy.org/
grab a binary and extract the folder so that the tidy.exe file is exposed.
add your tidy path to your system/user environment "path" list

SET UP XMLSTARLET:
https://sourceforge.net/projects/xmlstar/files/
grab the binary
add the path to your system/user variables



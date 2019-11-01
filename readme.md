Search the project for "techuserDir" and replace the path with your git skywest-techuser path.

this project utilizes a few command line tools: apache ant, xmlTidy, xmlStarlet. (you'll need to have these downloaded and add the paths to your ENV variables to make their respective commands available on the cli.

## SETUP__________________________________________________

**SET UP APACHE ANT:**
grab a binary:
https://ant.apache.org/bindownload.cgi

set a system environment called ANT_HOME and have it point to your ant bin.

*-to set java properties:* 
1.create a file in your home directory called "antrc_pre.bat"
2.add these lines of code:

@echo off
SET "ANT_OPTS=-DentityExpansionLimit=100000"

**SET UP XMLTIDY:**
http://binaries.html-tidy.org/
grab a binary and extract the folder so that the tidy.exe file is exposed.
add your tidy path to your system/user environment "path" list

**SET UP XMLSTARLET:**
https://sourceforge.net/projects/xmlstar/files/
grab the binary
add the path to your system/user variables


## HOW TO USE_____________________________________________

The main file to run for the project is antMain.bat.
You'll need to give it administrative permissions to run some commands (like restarting tomcat).
I setup a ant shortcut file pointing to antMain.bat in my home directory and set the 'run as administrator' option to true,
this way you can, on windows, type win+r and then just type 'ant' and it will launch the program for you.


## ABOUT __________________________________________________


There are 5 sections for the program.

1. **Antrunner/Xpath** - this guy is the bread and butter of what i use this program for. I replaced my eclipse program with just this section and added a lot of customization for each doctypes. 
2. **Watch Css** - this just starts the 'npm start prod' command in doctypes bringing up the css compiler
3. **Timer** - I used this moreso on days where I had a lot of publishing and I needed a way to track all my jobs and what stage they were on without going into jobs history tab in techpublisher to remind myself where im at.
4. **Open ContentURL** - after copying a contentURL string from techview, you can initiate this tool to bring up the contentURL xml you copied in foxe xml editor
5. **toggle tomcat** - determines if tomcat is on/off and toggles it on your local machine.



@echo off
REM *******************************
REM Compiler for the uploader class
REM *******************************

REM First we need to compile the class
javac Uploader.java -cp commons-net-1.4.1\commons-net-1.4.1.jar
javac Checker.java

REM Now we create a Jar file
jar cvf UnsignedUploader.jar *.class

REM Create a new new key file...
keytool -genkey -alias signFiles -keystore keystore -keypass abc123 -dname "cn=Demo" -storepass abc123

REM Sign the applet...
jarsigner -keystore keystore -storepass abc123 -keypass abc123 -signedjar Uploader.jar  UnsignedUploader.jar signFiles

REM Sign the ftp library...
jarsigner -keystore keystore -storepass abc123 -keypass abc123 -signedjar Net.jar  commons-net-1.4.1\commons-net-1.4.1.jar signFiles

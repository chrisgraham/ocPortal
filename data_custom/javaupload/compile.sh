# *******************************
# Compiler for the uploader class
# *******************************

# First we need to compile the class
javac Uploader.java -cp /System/Library/Frameworks/JavaVM.framework/Versions/1.5.0/Home/lib/plugin.jar:commons-net-1.4.1/commons-net-1.4.1.jar
javac Checker.java

# Now we create a Jar file
jar cvf UnsignedUploader.jar *.class

# Create a new new key file...
if [ -f keystore ];
then
	rm keystore
fi
keytool -genkey -alias signFiles -keystore keystore -keypass $2 -dname "cn=$1" -storepass $2 -validity 999

# Sign the applet...
jarsigner -keystore keystore -storepass $2 -keypass $2 -signedjar Uploader.jar  UnsignedUploader.jar signFiles

# Sign the ftp library...
jarsigner -keystore keystore -storepass $2 -keypass $2 -signedjar Net.jar  commons-net-1.4.1/commons-net-1.4.1.jar signFiles

# Overwrite in web dir
rm ../../data/javaupload/Uploader.jar
cp Uploader.jar ../../data/javaupload/Uploader.jar

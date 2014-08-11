#!/bin/bash

# Builds Android version of Hextris using Cordova Crosswalk
# Be sure Ant and Android are in your path. For me, the command to add them is the following:
export PATH=$PATH:/Applications/eclipse/plugins/org.apache.ant_1.8.4.v201303080030/bin:/Users/noah/Documents/Development/Android/android-sdk-macosx/platform-tools/
# Opts: 
#	--release: builds release version of app, signs it with app key
#	--run: runs app on connected Android device in debug mode. Must be second arg, use --debug as first arg if you wish to run a debug version of app

echo "Pulling latest from Git..."
cd assets/www/
rm -rf hextris
git clone https://github.com/hextris/hextris

# Remove unnecessary files from package
cd hextris
rm *.psd favicon.ico README.md LICENSE

echo "Building..."
cd ../../../

if [ "$1" == "--release" ];
then
	rm bin/Hextris-release.apk
	./cordova/build --release
	# cp bin/Hextris-release-unsigned.apk bin/Hextris-release.apk
	# jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ../hextris-key.keystore bin/Hextris-release.apk hextris
else 
	./cordova/build
fi

if [ "$2" == "--run" ];
then
	echo "Running on device..."
	./cordova/run --nobuild
fi
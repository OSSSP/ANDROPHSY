#!/bin/sh
#
chmod 755 files/adb.osx files/adb.linux

systype=$(uname -s)

case x"$systype" in
	xLinux*)
		adb="files/adb.linux";;
	xDarwin*)
		adb="files/adb.osx";;
	*)
		echo "Unrecognized system type $systype. adb must be on your path."
		adb="adb";;
esac

echo "[*] Testing adb usability"
echo ""
read -p "Plug in your phone and press ENTER to continue ..."
state=$($adb get-state)
if [ "X$state" != "device" ]; then
	echo ""
	echo "Watch your phone. If you see the \"Allow USB debugging\" prompt,"
	echo "tap on the \"Always allow from this computer\" checkbox,"
	echo "then tap OK."
	echo ""
	echo "If this script appears to be stuck at \"Waiting for your phone to appear\","
	echo "then you should try unplugging and re-plugging it to get the"
	echo "permission prompt for USB debugging to appear."
	echo "If you've already done that, you should tap on the USB icon"
	echo "in the notifications area that says \"Connected as a media device\"."
	echo "On the \"USB computer connection\" page, switch between"
	echo "\"Camera\" and \"Media Device\" to see if the device appears."
fi
echo "[*] Waiting for your phone to appear..."
echo "Watch your phone. Unlock it and give permission for the install to run."
$adb wait-for-device
#echo "[*] Your phone is detected and ready for unrooting."
#echo ""
#echo "[*] Starting unrooting program."
adb shell "su -c /system/xbin/unroot"
echo ""
echo "--- All Finished ---"

adb uninstall eu.chainfire.supersu
echo "supersu uninstalled"
adb uninstall eu.chainfire.adbd
echo "adbd insecure app uninstalled"

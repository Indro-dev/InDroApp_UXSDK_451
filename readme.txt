This app is a customized version of UXSDK sample using SDK version 4.5.1.
Each important file in the application has an introductory comment describing the purpose of the file.
When opening he project in XCode make sure to open the .xcworkspace file.
The .xcworkspace file can be found in /Sample\ Code/SwiftSampleCode/UXSDKSwiftSample.xcworkspace


The instructions for using this app are as follows:

	1) Load app into iPad from XCode
	2) Connect iPad to RC
	3) Power on RC, Drone, and Manifold
	4) Run the djiosdk-mobile-sample program as described in the DJI SDK documentation
	5) Restart iPad app then open it 
	6) Navigate to Live Data Stream tile at bottom of app
	7) You should see <The connected Product is: Optional("Matrice")>   //Optional means the pointer to the Product instance is nullable
	8) Then click the "Get some data" button 

You should see in the ubuntu terminal:

	Data recieved: 0xbe8e5018
	Made call to sendData()

Then the iPad app will crash

//The 0xbe5018 comes from the frame header, which is not a nicely encoded string. Use the new sendDataToMSDK() function for easier parsing of Data Transparent Transmission


This means the iPad has sent a message to the Drone which has then called a function sendData() to reply to the iPad.
When the iPad recieves the reply it crashed the app for unknown reasons. 

Going forward with this app:

The newest version of the OSDK (3.7) has changed the djiOSDK-mobile-sample to include a function 

	sendDataToMSDK(Vehicle* vehicle, uint8_t* data, uint8_t len)

which may function better that the current function. This new funtion is designed for Data Transparent Transmission, which means the data pointer should point directly to the data, and the frame doesn't have to be parsed.

Use the app to send data without recieving data (useful for designing and testing custom data parsing):

	1) on the manifold, open the terminal and type in: cd /home/ubuntu/Onboard-SDK/sample/linux/mobile
	2) then type: gedit mobile_sample.cpp
	3) now comment out lines 57 amd 59. they should be std::cout<<"Made call to sendData()\n\n";, and sendData(vehicle);, respectively.
	4) rebuild the app according to the instructions in DJI SDK Documentation

You should now be able to send data from the MSDK without it crashing.
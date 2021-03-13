

# Application Goal
This application provides you a list of products. Which enables you to buy the product you want and also enables you to add any product for sale



# Installation

1. Install  Xcode 10.1 


2. Unarchive the downloaded .zip file. This will extract the Xcode project, which you’ll be able to compile and run, by following the next steps.

3. Open up a terminal and navigate to the downloaded folder (by running “cd ~/Users/path_to_folder/Shooping List App”)

4. Install CocoaPods and make sure it is up to date. Please go to https://cocoapods.org if you are not familiar with pods.

5. Run “pod update” in your terminal, in order to make sure your cocoa pod software is up to date. This will ensure you’ll be working with the latest version of all the pods that this project is relying on

6. In the terminal window, run “pod install” command to install the following pods
```
pod installed  

pod 'Firebase/Core'
pod 'Firebase/Firestore'
pod 'Firebase/Storage'
pod 'Gallery'      
pod 'NVActivityIndicatorView/AppExtension'
pod 'JGProgressHUD'
```

7. Open the file “Shopping List.xcworkspace” with Xcode. Then go to Product -> Run (or press Command + R). The project should now be running on an iOS simulator (or device).



# Architecture 
It is MVC architecture ,   the app was divided  to  groubs:  
Model groub contains files that represents the shape of the data. 
View group contains files that display model data to the user
Controller group contains files handles the user request 
Netwoking group contains files that handle network action 
Helper group contains file that gives some facilitates like wrap some useful functionality that you're going to reuse over and over again 



# Instructions
Swift 4.2 usage with XCode 10.1 



# Author 
AOmar --  AhmedOmar042@gmail.com



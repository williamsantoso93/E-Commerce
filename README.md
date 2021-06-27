# E-Commerce

Assumption :
* Tester have installed cocoapods and do ```pod install``` before running the proeject
* Open ```E-Commerce.xcworkspace``` to run the project
* Use core data for local storage
* Create in Xcode 12.5.1 and use iOS 14.5 as deployment
* Tested using iPhone 11 simulator and iPhone Xr real device
* User only use iPhone
* Project created in light mode
* UI created by using Storyboard
* No auth or any verification when Sign in button tap (go to Home page directly)
* Using firebase for google and facebook auth
* When program close user have login again
* Category is not tappable (no action)
* Feed and cart page is empty
* Like status (Love icon) is tappable
* Cannot update like status product after bought
* No confirmation alert when buy product
* Back to root after product bought
* Add feature to delete all purchase history


Used third party library (cocoapods) :
| Pod                       |
|-------------------------- |
| pod 'Firebase/Analytics'  | 
| pod 'FirebaseUI'          |
| pod 'FirebaseUI/Auth'     |
| pod 'FirebaseUI/Google'   |
| pod 'FirebaseUI/Facebook' |
| pod 'SDWebImage'          |
| pod 'FBSDKLoginKit'       |

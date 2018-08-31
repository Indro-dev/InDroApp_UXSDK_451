//
//  AppDelegate.swift
//  UXSDK Sample
//
//  Copyright © 2016 DJI. All rights reserved.
//

/*
    This is version one of the data communication app, build using the iOS SDK 4.5.1
 
    Due to compatibility issues it is easier to build and edit a new sample from the DJI github, that it is to update
    the SDK version of a current sample. So this app is the first iteration of a Open Transparent Transmission
    communication app for sending data between a mobile device and the Onboard SDK
 
    This app is designed to be a usable version of the UXSDK sample app, with an added section to develop and test
    data communication between the mobile an drone. As it stands, there is an extra scene added to the sample which
    displays information.
 
    When testing this app make sure that the RC is connected to the drone before launching the app,
    otherwise the app will not reliably connect to the drone. When done properly the text box should read
    "The Connected Product is (optional) Matrice 100"
*/

import UIKit
import Foundation
import DJISDK

//To use DJI Bridge app, change `useBridge` to true and add bridge app IP address in `debugID`
let useBridge = false
let debugIP = "BRIDGE_APP_IP_ADDRESS_HERE"


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    //Creating references an instances here
    var window: UIWindow?
    var communicationsViewController:CommunicationsViewController?
    open var productCommunicationManager = ProductCommunicationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Start the registration at the launch of the app. This can be retriggered at anytime from the main view.
        // DJI App key needs to be registered in the Info.plist before calling this method.
        self.productCommunicationManager.registerWithProduct()
        
        /* debugging */
        //Print the address of appDelegate instance (self)
        print("\nThe Address of appDelegate referenced by appDelegate is: \(self)\n")
        
        //Print the address of the communicationsViewController from the appDelegate reference
        print("\nThe Address of communicationsViewController referenced by appDelegate is: \(String(describing: self.communicationsViewController))\n")
        return true
    }
}


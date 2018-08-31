//
//  AppDelegate.swift
//  UXSDK Sample
//
//  Copyright © 2016 DJI. All rights reserved.
//

import UIKit
import Foundation
import DJISDK

//To use DJI Bridge app, change `useBridge` to true and add bridge app IP address in `debugID`
let useBridge = false
let debugIP = "BRIDGE_APP_IP_ADDRESS_HERE"


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    
    //open var productCommunicationManager = ProductCommunicationManager()
    //open var communicationsViewController:CommunicationsViewController?
    //Problem seems to be with OnboardSDKDevice instance
    //open var osdkDevice:OnboardSDKDevice?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Start the registration at the launch of the app. This can be retriggered at anytime from the main view.
        // DJI App key needs to be registered in the Info.plist before calling this method.
        // self.productCommunicationManager.registerWithProduct()
        return true
    }
    
}


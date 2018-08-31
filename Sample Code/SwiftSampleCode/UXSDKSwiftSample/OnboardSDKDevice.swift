//
//  OnboardSDKDevice.swift
//  UXSDKSwiftSample
//
//  Created by Benjamin Ursel on 2018-06-13.
//  Copyright © 2018 DJI. All rights reserved.
//

/*
    This file is the abstraction of the onboard SDK. It provides methods that the onboard SDK interfaces with, and allows the onboard SDK to pass data to the MSDK.
 */

import UIKit
import Foundation
import DJISDK

//This class is an abstraction on the Onboard sdk. It is used to handle Onboard SDK events with the Mobile SDK
class OnboardSDKDevice: DJIOnboardSDKDevice, DJIOnboardSDKDeviceDelegate{

    //MARK: Properties
    open var appDelegate = UIApplication.shared.delegate as! AppDelegate
    weak var connectedProduct:DJIBaseProduct? = nil
    
    //MARK DJIOnboardSDKDeviceDelegate
    //This converts Data type to a Dtring
    func commandIDStringFromData(data: Data) -> String{
        
        if let string = String(data: data, encoding: .utf8) {
            return string
        } else {
            NSLog("not a valid UTF-8 sequence")
            return "not a valid UTF-8 sequence"
        }
        
    }
    
    //This is called when the OSDK sends a message to the MSDK
    //Handle the message here
    //App crashes when this is called
    func onboardSDKDevice(_ osdkDevice: DJIOnboardSDKDevice, didSendDataToMobile data: Data) {
        var dataString:String? = nil
        dataString = commandIDStringFromData(data: data)
        appDelegate.communicationsViewController?.DataDisplay?.text = dataString
    }
    
    func onboardSDKDevice(_ osdkDevice: DJIOnboardSDKDevice, didActivateWithOnboardSDKVersion osdkVersion: String) {
        appDelegate.communicationsViewController?.DataDisplay?.text = osdkVersion
    }
    
    //Call this message to send data from MSDK to OSDK
    //Message sends sucessfully
    override func sendDataFromMobile(toOnboard data: Data, withCompletion completion: DJICompletionBlock? = nil) {
        //This prints to the screen
        //mainViewController?.communicationsViewController?.DataDisplay?.text = "Waiting for response"
        //This sends data to OSDK, but crashes before returning
        super.sendDataFromMobile(toOnboard: data, withCompletion: nil)
    }
}

//
//  OnboardSDKDevice.swift
//  UXSDKSwiftSample
//
//  Created by Benjamin Ursel on 2018-06-13.
//  Copyright © 2018 DJI. All rights reserved.
//


import UIKit
import Foundation
import DJISDK

class OnboardSDKDevice: DJIOnboardSDKDevice, DJIOnboardSDKDeviceDelegate{

    //MARK: Properties
    open weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    var connectedProduct:DJIBaseProduct? = nil

    //MARK DJIOnboardSDKDeviceDelegate
    func commandIDStringFromData(data: Data) -> String{
        let string = String(data: data, encoding: .ascii)
        return (string ?? "No data available")
    }
    
    func onboardSDKDevice(_ osdkDevice: DJIOnboardSDKDevice, didSendDataToMobile data: Data) {
        var dataString:String? = nil
        dataString = commandIDStringFromData(data: data)
        appDelegate?.communicationsViewController.DataDisplay.text = dataString
    }
    
    func onboardSDKDevice(_ osdkDevice: DJIOnboardSDKDevice, didActivateWithOnboardSDKVersion osdkVersion: String) {
        appDelegate?.communicationsViewController.DataDisplay.text = osdkVersion
    }
    
    func sendData(toOnboard data: Data, withCompletion completion: DJICompletionBlock? = nil) {
        
    }
}

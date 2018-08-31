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
    weak var connectedProduct:DJIBaseProduct? = nil
    weak var communicationsViewController:CommunicationsViewController!

    
    init(communicationsViewController: CommunicationsViewController){
        super.init()
        self.communicationsViewController = communicationsViewController
    }
 
    //MARK DJIOnboardSDKDeviceDelegate
    func commandIDStringFromData(data: Data) -> String{
        let string = String(data: data, encoding: .ascii)
        return (string ?? "No data available")
    }
    
    func onboardSDKDevice(_ osdkDevice: DJIOnboardSDKDevice, didSendDataToMobile data: Data) {
        var dataString:String? = nil
        dataString = commandIDStringFromData(data: data)
        communicationsViewController?.DataDisplay?.text = dataString
    }
    
    func onboardSDKDevice(_ osdkDevice: DJIOnboardSDKDevice, didActivateWithOnboardSDKVersion osdkVersion: String) {
        communicationsViewController?.DataDisplay?.text = osdkVersion
    }
    
    override func sendDataFromMobile(toOnboard data: Data, withCompletion completion: DJICompletionBlock? = nil) {
        //This prints to the screen
        //mainViewController?.communicationsViewController?.DataDisplay?.text = "Waiting for response"
        //This sends data to OSDK, but crashes before returning
        super.sendDataFromMobile(toOnboard: data, withCompletion: nil)
    }
}

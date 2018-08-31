//  CommunicationsViewController.swift
//  UXSDKSwiftSample
//
//  Created by Benjamin Ursel on 2018-05-23.
//  Copyright © 2018 DJI. All rights reserved.
//

/*
    This file is a custom created file corrosponding to the view communicationLayout scene. This file was created to
    control the flow of open protocol information between the MSDK and the OSDK.
 
    The purpose of this file is to control the views from communicationLayout.scene. The DataDisplay is where the status
    of the drone and data sent from the drone are to be displayed.
 */

import UIKit
import Foundation
import DJISDK
import DJIUXSDK


class CommunicationsViewController: UIViewController, UITextViewDelegate {

    
    //MARK: Properties
    //This creates the text box for displaying data
    @IBOutlet weak var DataDisplay: UITextView!
   
    //Give this instancea reference to the appDelegate
    open weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    //Create an instance to OnboardSDKDevice
    open var onboardSDKDevice = OnboardSDKDevice()
    
    //MARK: Methods
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(true)
        
        //Gives the appDelegate a reference to here
        appDelegate?.communicationsViewController = self
        
        //Display the connected model
        DataDisplay?.text = "The connected Product is: \(String(describing: appDelegate?.productCommunicationManager.connectedProduct?.model))"
       
        /* debugging */
        print("\nThe address of communicationViewController referenced by communicationsViewController is: \(self)\n")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: Actions
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //This is called when getData is tapped
    
    //It sends a message to the manifold when getData button is pushed
    @IBAction func getData(_ sender: UIButton) {
    
        //Create 4 bytes of 0's
        let data = Data(count: 4)
        
        //Makes sendDataFromMobile method call on connected osdkDevice
        self.onboardSDKDevice.sendDataFromMobile(toOnboard: data, withCompletion: { error in
            
            if error != nil {
                NSLog((error?.localizedDescription)!)
            } else {
                NSLog("send success")
            }
        })
        
        /* App crashes after exiting scope with EXC_BAD_ACCESS */
    
    }

}

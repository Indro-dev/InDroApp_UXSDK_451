//  CommunicationsViewController.swift
//  UXSDKSwiftSample
//
//  Created by Benjamin Ursel on 2018-05-23.
//  Copyright © 2018 DJI. All rights reserved.
//

import UIKit
import Foundation
import DJISDK
import DJIUXSDK


class CommunicationsViewController: UIViewController, UITextViewDelegate {

    //MARK: Properties
    @IBOutlet weak var DataDisplay: UITextView!
   
    open weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    weak var mainViewController:MainViewController!
    weak var osdkDevice:OnboardSDKDevice!
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewController.communicationsViewController = self
        mainViewController.productCommunicationManager?.connectToProduct()
        mainViewController.productCommunicationManager?.connectedProduct = DJISDKManager.product()
        if (mainViewController.productCommunicationManager?.connectedProduct?.model != nil){
            self.DataDisplay?.text = (mainViewController.productCommunicationManager?.connectedProduct?.model)
        }
        self.osdkDevice = OnboardSDKDevice(communicationsViewController: self)
        self.osdkDevice?.delegate = self.osdkDevice
        DataDisplay.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: Actions
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func getData(_ sender: UIButton) {
        //Create 4 bytes of 0's
        let data = Data(count: 4)
        self.DataDisplay?.text = "trying to send message"
        self.osdkDevice?.sendDataFromMobile(toOnboard: data, withCompletion: nil)
        //App crashes after exiting scope with EXC_BAD_ACCESS
    }

}

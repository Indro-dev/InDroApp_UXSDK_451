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
    
    //This is instantiated as a UIViewController as soon as app launches
    //The reference in appDelegate is reassigned every time the view launches
    
    //MARK: Properties
    @IBOutlet weak var DataDisplay: UITextView!
    open weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate?.communicationsViewController = self
        appDelegate?.productCommunicationManager.connectToProduct()
        appDelegate?.productCommunicationManager.connectedProduct = DJISDKManager.product()
        if (appDelegate?.productCommunicationManager.connectedProduct?.model != nil){
            self.DataDisplay.text = (appDelegate?.productCommunicationManager.connectedProduct.model)
        }
        //This works and will register the manifold
        appDelegate?.osdkDevice = OnboardSDKDevice()
        appDelegate?.osdkDevice?.delegate = appDelegate?.osdkDevice
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: Actions
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //This doesn't update text until after the function has returned
    @IBAction func getData(_ sender: UIButton) {
        //Empty
    }
}

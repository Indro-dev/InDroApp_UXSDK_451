//
//  MainViewController.swift
//  UXSDK Sample
//
//  Copyright © 2016 DJI. All rights reserved.
//

/*
 This is the view controller for the main scene, which launches whn the app open. This file is similar to the default file which ships with the UXSDK sample, because were not too interested in changing the initial behaviour
 */

import UIKit
import DJISDK

class MainViewController: UITableViewController {
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Creating onscreen "views" for code to interface with
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var registered: UILabel!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var connected: UILabel!
    @IBOutlet weak var connect: UIButton!
    
    //This method is called by UIKit when the mainViewController scene is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(productCommunicationDidChange), name: Notification.Name(rawValue: ProductCommunicationManagerStateDidChange), object: nil)
    }
    
    //This method is called by UIKit every time the mainViewController will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var version = DJISDKManager.sdkVersion()
        if version == "" {
            version = "N/A"
        }
        self.version.text = "Version \(version)"
    }
    
    //This method is called when the register button is tapped
    @IBAction func registerAction() {
        self.appDelegate.productCommunicationManager.registerWithProduct()
    }
    
    //This method is called when the connect button is tapped
    @IBAction func connectAction() {
        self.appDelegate.productCommunicationManager.connectToProduct()
    }
    
    func productCommunicationDidChange() {
        //If this demo is used in China, it's required to login to your DJI account to activate the application. Also you need to use DJI Go app to bind the aircraft to your DJI account. For more details, please check this demo's tutorial.
        DJISDKManager.userAccountManager().logIntoDJIUserAccount(withAuthorizationRequired: false) { (state, error) in
            if(error != nil){
                NSLog("Login failed: %@" + String(describing: error))
            }
        }
        
        if self.appDelegate.productCommunicationManager.registered {
            self.registered.text = "YES"
            self.register.isHidden = true
        } else {
            self.registered.text = "NO"
            self.register.isHidden = false
        }
        
        if self.appDelegate.productCommunicationManager.connected {
            self.connected.text = "YES"
            self.connect.isHidden = true
        } else {
            self.connected.text = "NO"
            self.connect.isHidden = false
        }
    }
}

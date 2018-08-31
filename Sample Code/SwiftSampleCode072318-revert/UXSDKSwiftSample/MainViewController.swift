//
//  MainViewController.swift
//  UXSDK Sample
//
//  Copyright © 2016 DJI. All rights reserved.
//

import UIKit
import Foundation
import DJISDK

class MainViewController: UITableViewController {
    
    //This accesses the existing app delegate and sets this view controller to the same delegate as AppDelegate
    //Can be used to register product at any time 
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var communicationsViewController:CommunicationsViewController?
    var productCommunicationManager:ProductCommunicationManager?
    
    //Outlets (Connections) to views on main storyboard
    @IBOutlet weak var version: UILabel!
    @IBOutlet weak var registered: UILabel!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var connected: UILabel!
    @IBOutlet weak var connect: UIButton!
    
    //This is run when the main view will load to be display
    //There is an observer on the ProductCommunicationDidChange and diplays a notification if it changes
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(productCommunicationDidChange), name: Notification.Name(rawValue: ProductCommunicationManagerStateDidChange), object: nil)
        
        productCommunicationManager = ProductCommunicationManager()
        productCommunicationManager?.registerWithProduct()
    }

    //This is run after view did load, just before the view appears
    //It sets up the variables for the instance of the MainViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var version = DJISDKManager.sdkVersion()
        if version == "" {
            version = "N/A"
        }
        
        self.version.text = "Version \(version)"

    }

    //Gives the user the option to call registerWithProduct() in ProductCommunicationsManager through the current appDelegate instance
    @IBAction func registerAction() {
        self.productCommunicationManager?.registerWithProduct()
    }
    
    //Again gives user option to call connectToProduct() method in ProductCommunicationsManager, through the current appDelegate instance
    @IBAction func connectAction() {
        self.productCommunicationManager?.connectToProduct()
    }
    
    func productCommunicationDidChange() {
        //If this demo is used in China, it's required to login to your DJI account to activate the application. Also you need to use DJI Go app to bind the aircraft to your DJI account. For more details, please check this demo's tutorial.
        
        DJISDKManager.userAccountManager().logIntoDJIUserAccount(withAuthorizationRequired: false) { (state, error) in
                if(error != nil){
                    NSLog("Login failed: %@" + String(describing: error))
                }
        }
        
        if (self.productCommunicationManager?.registered)! {
            self.registered.text = "YES"
            self.register.isHidden = true
        } else {
            self.registered.text = "NO"
            self.register.isHidden = false
        }
        
        if (self.productCommunicationManager?.connected)! {
            self.connected.text = "YES"
            self.connect.isHidden = true
        } else {
            self.connected.text = "NO"
            self.connect.isHidden = false
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
            if let communicationsViewController = segue.destination as? CommunicationsViewController {
                communicationsViewController.mainViewController = self
        }
    }
}

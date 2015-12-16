//
//  ViewController.swift
//  FaceTube
//
//  Created by Dulio Denis on 12/7/15.
//  Copyright © 2015 Dulio Denis. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
        
    }
    
    
    // MARK: Facebook Login
    
    @IBAction func fbButtonTapped(sender: UIButton!) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            
            if facebookError != nil {
                print("Facebook Login Failed. Error \(facebookError.debugDescription)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in with Facebook: \(accessToken)")
                
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
                    if error != nil {
                        print("Login failed: \(error)")
                    } else {
                        print("Logged in: \(authData)")
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                })
            }
        }        
    }
    
    
    // MARK: Email Login
    
    @IBAction func loginAttempt(sender: UIButton!) {
        if let email = emailField.text where email != "",
           let password = passwordField.text where password != "" {
            
            DataService.ds.REF_BASE.authUser(email, password: password, withCompletionBlock: { error, authData in
                if error != nil {
                    print(error)
                }
            })
            
        } else {
            showErrorAlert("Login Attempt", message: "You need to enter both an email and password to login.")
        }
    }
    
    
    // MARK: Alert function
    
    func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}


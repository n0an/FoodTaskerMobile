//
//  LoginViewController.swift
//  FoodTaskerMobile
//
//  Created by Anton Novoselov on 01/05/2017.
//  Copyright © 2017 Anton Novoselov. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var bLogin: UIButton!
    @IBOutlet weak var bLogout: UIButton!
    @IBOutlet weak var switchUser: UISegmentedControl!
    
    var fbLoginSuccess = false
    
    var userType: String = USERTYPE_CUSTOMER
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (FBSDKAccessToken.current() != nil) {
            
            bLogout.isHidden = false
            FBManager.getFBUserData(completionHandler: {
                
                self.bLogin.setTitle("Continue as \(User.currentUser.email!)", for: .normal)
                
            })
        } else {
            bLogout.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userType = userType.capitalized
        
        if (FBSDKAccessToken.current() != nil && fbLoginSuccess == true) {
            performSegue(withIdentifier: "\(userType)View", sender: self)
        }
    }
    
    @IBAction func facebookLogout(_ sender: AnyObject) {
        
        APIManager.shared.logout { (error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            FBManager.shared.logOut()
            User.currentUser.resetInfo()
            
            self.bLogout.isHidden = true
            self.bLogin.setTitle("Login with Facebook", for: .normal)
            
        }
        
    }
    
    @IBAction func facebookLogin(_ sender: AnyObject) {
        
        if (FBSDKAccessToken.current() != nil) {
            
            APIManager.shared.login(userType: userType, completionHandler: { (error) in
                
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                self.fbLoginSuccess = true
                self.viewDidAppear(true)
                
            })
            
            
        } else {
            
            FBManager.shared.logIn(
                withReadPermissions: ["public_profile", "email"],
                from: self,
                handler: { (result, error) in
                    
                    if (error == nil) {
                        
                        FBManager.getFBUserData(completionHandler: {
                            
                            APIManager.shared.login(userType: self.userType, completionHandler: { (error) in
                                
                                guard error == nil else {
                                    print(error!.localizedDescription)
                                    return
                                }
                                
                                self.fbLoginSuccess = true
                                self.viewDidAppear(true)
                                
                            })

                        })
                    }
            })
        }
    }
    
    @IBAction func switchAccount(_ sender: AnyObject) {
        
        userType = switchUser.selectedSegmentIndex == 0 ? USERTYPE_CUSTOMER : USERTYPE_DRIVER
        
    }
}

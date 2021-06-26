//
//  LoginViewController.swift
//  E-Commerce
//
//  Created by William Santoso on 26/06/21.
//

import UIKit
import FirebaseUI
import GoogleSignIn
import FBSDKLoginKit


class LoginViewController: UIViewController, LoginButtonDelegate {
    
    @IBOutlet weak var gSignInButton: GIDSignInButton!
    @IBOutlet weak var loginWithFacebookView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
        
        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
        } else {
            let loginButton = FBLoginButton()
            loginButton.center = loginWithFacebookView.center
            loginButton.delegate = self
            loginButton.permissions = ["email"]
            loginWithFacebookView.addSubview(loginButton)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
     }

    @IBAction func gSignInAction(_ sender: Any) {
        print("google")
        
    }
    func signIn() {
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    @IBAction func signInAction(_ sender: Any) {
        performSegue(withIdentifier: "HomeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "HomeSegue" {
//            let tabBarVC = TabBarViewController()
//            tabBarVC.viewControllers = [HomeViewController()]
//
//            self.present(tabBarVC, animated: true, completion: nil)
//        }
    }
}


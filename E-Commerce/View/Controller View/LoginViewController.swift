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


class LoginViewController: UIViewController, LoginButtonDelegate, GIDSignInDelegate {
    @IBOutlet weak var gSignInButton: GIDSignInButton!
    @IBOutlet weak var loginWithFacebookView: UIView!
    @IBOutlet weak var rememberMeView: UIStackView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var borderCheckmarkView: UIView!
    
    var check = false {
        didSet {
            if check {
                checkmarkImage.image = UIImage(systemName: "checkmark")
            } else {
                checkmarkImage.image = UIImage()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().delegate = self
        
        borderCheckmarkView.layer.borderWidth = 1
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        rememberMeView.addGestureRecognizer(tap)
        
        setupFBLoginButtonView()
    }
    
    func setupFBLoginButtonView() {
        let loginButton = FBLoginButton()
        loginButton.center = loginWithFacebookView.center
        loginButton.delegate = self
        loginButton.permissions = ["email"]
        loginWithFacebookView.addSubview(loginButton)
    }
    
    @objc func tapped() {
        check.toggle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func signIn() {
        performSegue(withIdentifier: "HomeSegue", sender: nil)
    }
    
    //MARK: - FacebookSignIn
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error == nil {
            signIn()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    //MARK: - Google SignIn
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            self.signIn()
        }
    }
    
    //MARK: - username sign in
    @IBAction func signInAction(_ sender: Any) {
        signIn()
    }
}


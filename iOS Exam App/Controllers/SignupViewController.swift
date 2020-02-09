//
//  SignupViewController.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-03.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class SignupViewController: UIViewController {
    
    private let loginManager = LoginManager()
    private let signupButton = FBLoginButton()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Welcome,\nsign up to get started"
        l.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        l.numberOfLines = 0
        l.sizeToFit()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.delegate = self
        loginManager.logOut()
        setupNavigationBar()
        setupViews()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8064885139, green: 0.6064415574, blue: 0.4238808751, alpha: 1)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.layer.cornerRadius = 15
        signupButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 25).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true 
    }
    
    private func performLogout() {
        let loginManager = LoginManager()
        loginManager.logOut()
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Error while to trying to sign out user: ", error)
        }
    }
    
}

extension SignupViewController: LoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        self.signupButton.isHidden = true
        if let error = error {
            self.signupButton.isHidden = false
            print("Error while login using Facebook: ", error)
            return
        }
        guard let stringToken = AccessToken.current?.tokenString else { return }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: stringToken)
        
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            
            if let error = error {
                self.signupButton.isHidden = false
                print("Error while authentifying with firebase: ", error)
                return
            }
            
            guard let userAdditionalInfo = authResult?.additionalUserInfo else { return }
            
            if userAdditionalInfo.isNewUser {
                
                let mapVC = MapViewController()
                self.navigationController?.pushViewController(mapVC, animated: true)
                
            } else {
                self.showAlert(title: "Please Login", message: "You already have an account at Silofit, please go back and Sign in", action: "Dismiss", handler: { (_) in
                    self.navigationController?.popViewController(animated: true)
                })
                self.performLogout()
                
            }
        }
    }
    
}

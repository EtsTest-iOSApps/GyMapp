//
//  LoginViewController.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-03.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController {
    
    private let loginManager = LoginManager()
    private let loginButton = FBLoginButton()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Hi there,\nwelcome back"
        l.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        l.numberOfLines = 0
        l.sizeToFit()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.delegate = self
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
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 15
        loginButton.clipsToBounds = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 25).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func performLogout() {
        let loginManager = LoginManager()
        loginManager.logOut()
    }
    
}

extension LoginViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {}
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        self.loginButton.isHidden = true
        if let error = error {
            self.loginButton.isHidden = false
            print("Error while login using Facebook: ", error)
            return
        }
        guard let stringToken = AccessToken.current?.tokenString else { return }
        let credential = FacebookAuthProvider.credential(withAccessToken: stringToken)
        
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            
            if let error = error {
                self.loginButton.isHidden = false
                print("Error while authentifying with firebase: ", error)
                return
            }
            
            guard let userAdditionalInfo = authResult?.additionalUserInfo else { return }
            
            if !userAdditionalInfo.isNewUser {
                let mapVC = MapViewController()
                self.navigationController?.pushViewController(mapVC, animated: true)
            } else {
                self.showAlert(title: "Please Sign up", message: "You don't have an account at Silofit, please join", action: "Dismiss", handler: { (_) in
                    self.navigationController?.popViewController(animated: true)
                })
                
                self.performLogout()
                
                Auth.auth().currentUser?.delete(completion: { (error) in
                    if let error = error {
                        print("Error while trying to delete user: ", error)
                        return
                    }
                })
            }
        }
    }
}

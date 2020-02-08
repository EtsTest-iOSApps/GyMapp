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
    
    let loginButton = FBLoginButton()
    
//    private let facebookSignInButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Sign in with Facebook", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
//        button.backgroundColor = #colorLiteral(red: 0.1771525145, green: 0.3373974264, blue: 0.6473301649, alpha: 1)
//        button.layer.cornerRadius = 25
//        button.addTarget(self, action: #selector(handleSignInFacebook), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.delegate = self
        setupNavigationBar()
        setupViews()
    }
    
    
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8064885139, green: 0.6064415574, blue: 0.4238808751, alpha: 1)
    }
    private func setupViews() {
        view.backgroundColor = .white
        //        view.addSubview(facebookSignInButton)
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 15
        loginButton.clipsToBounds = true
        
        //        facebookSignInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        //        facebookSignInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        //        facebookSignInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //        facebookSignInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
//    @objc private func handleSignInFacebook() {
//        print("login Facebook")
//        let mapVC = MapViewController()
//        navigationController?.pushViewController(mapVC, animated: true)
//    }
    
}

extension LoginViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print("Error while login using Facebook: ", error)
            return
        }
        guard let stringToken = AccessToken.current?.tokenString else { return }
        let credential = FacebookAuthProvider.credential(withAccessToken: stringToken)
        
        
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            
            if let error = error {
                print("Error while authentifying with firebase: ", error)
                return
            }
            
            let mapVC = MapViewController()
            self.navigationController?.pushViewController(mapVC, animated: true)
        }
    }
    
    
}

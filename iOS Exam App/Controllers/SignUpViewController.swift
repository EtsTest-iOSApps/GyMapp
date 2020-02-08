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
    
    let signupButton = FBLoginButton()
    
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Welcome,\nSign up to get started"
        l.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        l.numberOfLines = 0
        l.sizeToFit()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
//    private let facebookSignUpButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Sign up with Facebook", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
//        button.backgroundColor = #colorLiteral(red: 0.1771525145, green: 0.3373974264, blue: 0.6473301649, alpha: 1)
//        button.layer.cornerRadius = 25
//        button.addTarget(self, action: #selector(handleSignUpFacebook), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.delegate = self
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

}

extension SignupViewController: LoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        if Auth.auth().currentUser == nil {
            return
        }
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

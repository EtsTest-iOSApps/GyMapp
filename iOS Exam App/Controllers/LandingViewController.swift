//
//  LadingViewController.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-03.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit
import Firebase

class LandingViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = #colorLiteral(red: 0.8064885139, green: 0.6064415574, blue: 0.4238808751, alpha: 1)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let joinNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join now", for: .normal)
        button.setTitleColor( #colorLiteral(red: 0.8064885139, green: 0.6064415574, blue: 0.4238808751, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.8064885139, green: 0.6064415574, blue: 0.4238808751, alpha: 1)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleJoin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        
        if Auth.auth().currentUser != nil {
            let mapVC = MapViewController()
            navigationController?.pushViewController(mapVC, animated: false)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setupViews() {
        view.addSubview(signInButton)
        view.addSubview(joinNowButton)
        
        if #available(iOS 11.0, *) {
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
            joinNowButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        } else {
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
            joinNowButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        }
        
        signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        joinNowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        joinNowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        joinNowButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func handleSignIn() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc private func handleJoin() {
        let signUpVC = SignupViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}


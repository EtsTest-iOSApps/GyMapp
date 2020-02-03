//
//  SignUpViewController.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-03.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let facebookSignUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up with Facebook", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = #colorLiteral(red: 0.1771525145, green: 0.3373974264, blue: 0.6473301649, alpha: 1)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleSignUpFacebook), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(facebookSignUpButton)
        facebookSignUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        facebookSignUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        facebookSignUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        facebookSignUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc private func handleSignUpFacebook() {
        print("SignUp Facebook")
        let mapVC = MapViewController()
        navigationController?.pushViewController(mapVC, animated: true)
    }

}

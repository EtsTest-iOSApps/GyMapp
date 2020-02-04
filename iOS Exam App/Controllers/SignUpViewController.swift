//
//  SignUpViewController.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-03.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Welcome,\nSign up to get started"
        l.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        l.numberOfLines = 0
        l.sizeToFit()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let facebookSignUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up with Facebook", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.backgroundColor = #colorLiteral(red: 0.1771525145, green: 0.3373974264, blue: 0.6473301649, alpha: 1)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleSignUpFacebook), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8064885139, green: 0.6064415574, blue: 0.4238808751, alpha: 1)
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
            UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.8064885139, green: 0.6064415574, blue: 0.4238808751, alpha: 1)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(facebookSignUpButton)
        facebookSignUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        facebookSignUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        facebookSignUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        facebookSignUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 25).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        
        
    }
    
    @objc private func handleSignUpFacebook() {
        print("SignUp Facebook")
        let mapVC = MapViewController()
        navigationController?.pushViewController(mapVC, animated: true)
    }

}

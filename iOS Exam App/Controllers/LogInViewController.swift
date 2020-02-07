//
//  LogInViewController.swift
//  iOS Exam App
//
//  Created by Merouane Tazeka on 2020-02-03.
//  Copyright © 2020 Merouane Tazeka. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let facebookSignInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in with Facebook", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = #colorLiteral(red: 0.1771525145, green: 0.3373974264, blue: 0.6473301649, alpha: 1)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleSignInFacebook), for: .touchUpInside)
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
    }
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(facebookSignInButton)
        
        facebookSignInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        facebookSignInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        facebookSignInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        facebookSignInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    
    @objc private func handleSignInFacebook() {
        print("login Facebook")
        let mapVC = MapViewController()
        navigationController?.pushViewController(mapVC, animated: true)
    }
}

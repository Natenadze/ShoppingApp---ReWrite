//
//  FirstPageVC.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 06.05.23.
//

import UIKit

class FirstPageVC: UIViewController {
    
    // MARK: - Properties
    let logoView = UIImageView()
    let loginButton = UIButton(type: .system)
    let registerButton = UIButton(type: .system)
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    // MARK: - Selectors
    
    @objc func loginButtonTapped() {
        let vc = AuthenticationVC(buttonTitle: "Login", isLogin: true)
        navigationController?.pushViewController(vc, animated: true)
    }
     
    @objc func registerButtonTapped() {
        let vc = AuthenticationVC(buttonTitle: "Register", isLogin: false)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - Style & Layout

extension FirstPageVC {
    
    func style() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        // logo
        logoView.image = UIImage(named: "city")
        
        // Login Btn
        loginButton.backgroundColor = .buttonCustomColor
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 6
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        // Register Btn
        registerButton.backgroundColor = .buttonCustomColor
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 6
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        
    }
    
    func layout() {
        view.addSubview(logoView)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
     
        NSLayoutConstraint.activate([
            
            // logo
            logoView.heightAnchor.constraint(equalToConstant: 200),
            logoView.widthAnchor.constraint(equalToConstant: 240),
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            
            // Login Btn
            loginButton.heightAnchor.constraint(equalToConstant: 56),
            loginButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginButton.trailingAnchor, multiplier: 2),
            
            // Register Btn
            registerButton.heightAnchor.constraint(equalToConstant: 56),
            registerButton.topAnchor.constraint(equalToSystemSpacingBelow: loginButton.bottomAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: registerButton.bottomAnchor, multiplier: 4),
            registerButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor)
        ])
    }
}


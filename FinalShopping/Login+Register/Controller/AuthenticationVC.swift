//
//  Login+RegisterVC.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 08.05.23.
//

import UIKit

class AuthenticationVC: UIViewController {
    
    // MARK: - Properties
    let topView = LogoView()
    let stackView = UIStackView()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let button = UIButton(type: .system)
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
    let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
    
    let isLogin: Bool
    let buttonTitle: String
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

    
    init(buttonTitle: String, isLogin: Bool) {
        self.buttonTitle = buttonTitle
        self.isLogin = isLogin
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func buttonTapped() {
        
        if isLogin {
            print("Login button in action")
        }else {
            print("Register button in action")
        }
        
        let vc  = ShoppingVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Style & Layout

extension AuthenticationVC {
    
    func style() {
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        // email
        
        emailTextField.placeholder = "Email"
        emailTextField.layer.cornerRadius = 6
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.backgroundColor = .systemGray6
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        
        // password
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.cornerRadius = 6
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.leftView = paddingView2
        passwordTextField.leftViewMode = .always
        
        
        // button
        button.backgroundColor = .buttonCustomColor
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
       
    }
    
    
    // MARK: - Layout
    
    func layout() {
        view.addSubview(topView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(button)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            // top view
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.bottomAnchor.constraint(equalTo: stackView.topAnchor),
            
            //
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            // stack
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

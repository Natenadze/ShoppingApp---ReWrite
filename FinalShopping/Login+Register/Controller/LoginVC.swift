//
//  Login+RegisterVC.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 08.05.23.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    // MARK: - Properties
    let topView = LogoView()
    let stackView = UIStackView()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton(type: .system)
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
    let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Selectors
    
    @objc func buttonTapped() {
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            // TODO: - // Handle error case
            print("Error in login")
            return
        }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let _ = error {
                print("error signin ")
                return
            }
            
            if let _ = result {
                let vm = ShoppingVM()
                let items = CoreDataManager.shared.fetchBusket()
                vm.basket = items
                let vc  = ShoppingVC(viewModel: vm)
                vc.view.accessibilityIdentifier = "ShoppingVC" // Set id for UI Tests
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
}



// MARK: - Style & Layout

extension LoginVC {
    
    func style() {
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        // stack
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        
        // email
        emailTextField.setup(withPlaceholder: "Email", paddingView: paddingView)
        
        // password
        passwordTextField.setup(withPlaceholder: "Password", paddingView: paddingView2)
        passwordTextField.isSecureTextEntry = true
        
        // button
        loginButton.setup(withTitle: "Login")
        loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    
    // MARK: - Layout
    
    func layout() {
        view.addSubview(topView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
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
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // stack
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

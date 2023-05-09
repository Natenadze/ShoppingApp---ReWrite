//
//  PaymentResult.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 09.05.23.
//

import UIKit

class PaymentResultVC: UIViewController {
    
    // MARK: - Properties
    
    let stackView = UIStackView()
    let label = UILabel()
    let imageView = UIImageView()
    let button = UIButton(type: .system)
    
    let image: UIImage
    let message: String
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    init(image: UIImage, message: String) {
        self.image = image
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selector
    @objc func buttonTapped() {
        print("Done")
    }
    
}


// MARK: - Style & Layout

extension PaymentResultVC {
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = message
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.backgroundColor = .buttonCustomColor
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func layout() {
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            // imageView
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            // stack
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // button
            button.heightAnchor.constraint(equalToConstant: 50),
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 2)
            
        ])
    }
}

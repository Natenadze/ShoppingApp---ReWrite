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
    
}


// MARK: - Style & Layout

extension PaymentResultVC {
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = message
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func layout() {
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

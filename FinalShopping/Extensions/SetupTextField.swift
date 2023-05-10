//
//  SetupTextField.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 10.05.23.
//

import UIKit

extension UITextField {
    
    func setup(withPlaceholder placeholder: String, paddingView: UIView) {
        self.placeholder = placeholder
        layer.cornerRadius = 6
        keyboardType = .emailAddress
        autocorrectionType = .no
        autocapitalizationType = .none
        backgroundColor = .systemGray6
        leftView = paddingView
        leftViewMode = .always
    }
    
    
}

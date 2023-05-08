//
//  LogoView.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 08.05.23.
//

import UIKit

class LogoView: UIView {
    
    // MARK: - Properties
    let titleLabel = UILabel()
    let logo = UIImageView()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


// MARK: - Style & Layout

extension LogoView {
    
    func style() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Welcome to City Mall!"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textColor = .darkGray
        
        logo.image = UIImage(named: "cityMall")
        logo.contentMode = .scaleAspectFit
    }
    
    func layout() {
        addSubview(titleLabel)
        addSubview(logo)
        
        NSLayoutConstraint.activate([
            
            // title
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 0),
            
            // logo
            logo.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            logo.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomAnchor.constraint(equalToSystemSpacingBelow: logo.bottomAnchor, multiplier: 2)
            
            
            
        ])
    }
}

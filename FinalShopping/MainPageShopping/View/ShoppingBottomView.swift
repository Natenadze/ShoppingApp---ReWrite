//
//  ShoppingBottomView.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 08.05.23.
//


import UIKit

class ShoppingBottomView: UIView {
    
    // MARK: - Properties
    let image = UIImageView()
    let dividerView = UIView()
    let quantityLbl = UILabel()
    let priceLbl = UILabel()
    let xSign = UILabel()
    let dolarSign = UILabel()
    let goToSummaryLbl = UILabel()
    
    
    
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

extension ShoppingBottomView {
    
    func style() {
        image.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        quantityLbl.translatesAutoresizingMaskIntoConstraints = false
        priceLbl.translatesAutoresizingMaskIntoConstraints = false
        xSign.translatesAutoresizingMaskIntoConstraints = false
        dolarSign.translatesAutoresizingMaskIntoConstraints = false
        goToSummaryLbl.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemTeal
        
        // image
        image.image = UIImage(systemName: "cart")
        image.tintColor = .white
        
        dividerView.backgroundColor = .white
        
        quantityLbl.text = "0"
        quantityLbl.textColor = .white
        
        priceLbl.text = "0"
        priceLbl.textColor = .white
        
        xSign.text = "x"
        xSign.textColor = .white
        
        dolarSign.text = "$"
        dolarSign.textColor = .white
        
        goToSummaryLbl.text = "Go to summary ❯"
        goToSummaryLbl.textColor = .white
        
        
    }
    
    func layout() {
        addSubview(image)
        addSubview(dividerView)
        addSubview(quantityLbl)
        addSubview(priceLbl)
        addSubview(xSign)
        addSubview(dolarSign)
        addSubview(goToSummaryLbl)
        
        
        NSLayoutConstraint.activate([
            // image
            image.heightAnchor.constraint(equalToConstant: 54),
            image.widthAnchor.constraint(equalToConstant: 64),
            image.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            image.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            // divider
            dividerView.heightAnchor.constraint(equalTo: image.heightAnchor, multiplier: 0.5),
            dividerView.widthAnchor.constraint(equalToConstant: 2),
            dividerView.leadingAnchor.constraint(equalToSystemSpacingAfter: image.trailingAnchor, multiplier: 0.7),
            dividerView.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            
            // quantity Label
            quantityLbl.leadingAnchor.constraint(equalToSystemSpacingAfter: dividerView.trailingAnchor, multiplier: 0.7),
            quantityLbl.topAnchor.constraint(equalTo: image.topAnchor),
            
            // price Label
            priceLbl.leadingAnchor.constraint(equalTo: quantityLbl.leadingAnchor),
            priceLbl.bottomAnchor.constraint(equalTo: image.bottomAnchor),
            
            xSign.topAnchor.constraint(equalTo: quantityLbl.topAnchor),
            xSign.leadingAnchor.constraint(equalToSystemSpacingAfter: quantityLbl.trailingAnchor, multiplier: 0.1),
            
            dolarSign.topAnchor.constraint(equalTo: priceLbl.topAnchor),
            dolarSign.leadingAnchor.constraint(equalToSystemSpacingAfter: priceLbl.trailingAnchor, multiplier: 0.1),
            
            goToSummaryLbl.centerYAnchor.constraint(equalTo: dividerView.centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: goToSummaryLbl.trailingAnchor, multiplier: 2)
            
        ])
        
        
        
        
    }
}

//
//  SummaryCell.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 11.05.23.
//

import UIKit



class SummaryCell: UITableViewCell {
    
    // MARK: - Create Cell Identifier
    static var identifier: String {
        return String(describing: self)
    }

    // MARK: - Properties
    
    let itemImage = UIImageView()
    let itemLbl = UILabel()
    let quantityLbl = UILabel()
    let xSign = UILabel()
    let priceSumLbl = UILabel()
    let dolarSign = UILabel()

    var busketModel: Busket! {
        didSet {
            setupCell()
        }
    }
    

    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        style1()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    // MARK: - Helper
    
    func setupCell() {
        itemImage.image = UIImage(data: busketModel.image ?? Data())
        itemLbl.text = busketModel.title
        quantityLbl.text = String(busketModel.quantity)
        priceSumLbl.text = busketModel.subTotal
    }
    

}


// MARK: - Style & Layout

extension SummaryCell {
    
    func style1() {
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemLbl.translatesAutoresizingMaskIntoConstraints = false
        priceSumLbl.translatesAutoresizingMaskIntoConstraints = false
        quantityLbl.translatesAutoresizingMaskIntoConstraints = false
        xSign.translatesAutoresizingMaskIntoConstraints = false
        dolarSign.translatesAutoresizingMaskIntoConstraints = false
        
      
        xSign.text = "x"
        dolarSign.text = "$"
        
    }
    
    func layout() {
        
        contentView.addSubview(itemImage)
        contentView.addSubview(itemLbl)
        contentView.addSubview(quantityLbl)
        contentView.addSubview(priceSumLbl)
        contentView.addSubview(xSign)
        contentView.addSubview(dolarSign)
        
        
        NSLayoutConstraint.activate([
            // image
            itemImage.heightAnchor.constraint(equalToConstant: 90),
            itemImage.widthAnchor.constraint(equalToConstant: 90),
            
            itemImage.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            itemImage.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: itemImage.bottomAnchor, multiplier: 1),
            
            // title
            itemLbl.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 3),
            itemLbl.leadingAnchor.constraint(equalToSystemSpacingAfter: itemImage.trailingAnchor, multiplier: 2),
            
            // quantity
            quantityLbl.leadingAnchor.constraint(equalTo: itemLbl.leadingAnchor),
            bottomAnchor.constraint(equalToSystemSpacingBelow: quantityLbl.bottomAnchor, multiplier: 3),
            xSign.leadingAnchor.constraint(equalToSystemSpacingAfter: quantityLbl.trailingAnchor, multiplier: 0.1),
            xSign.centerYAnchor.constraint(equalTo: quantityLbl.centerYAnchor),
            
            // total price
            trailingAnchor.constraint(equalToSystemSpacingAfter: dolarSign.trailingAnchor, multiplier: 2),
            dolarSign.centerYAnchor.constraint(equalTo: quantityLbl.centerYAnchor),
            
            dolarSign.leadingAnchor.constraint(equalToSystemSpacingAfter: priceSumLbl.trailingAnchor, multiplier: 0.1),
            priceSumLbl.centerYAnchor.constraint(equalTo: quantityLbl.centerYAnchor)
        
            
        ])
        
        
        
    }
}

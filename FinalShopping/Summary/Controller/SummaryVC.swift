//
//  SummaryVC.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 09.05.23.
//

import UIKit

class SummaryVC: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private let bottomView = SummaryView()
    private let payButton = UIButton(type: .system)
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        style()
        layout()
    }
    
    // MARK: -  Selectors
    
    @objc func payButtonTapped() {
        
        guard let image = UIImage(named: "decline") else { return }
        
        // TODO: - put related message
        let vc = PaymentResultVC(image: image, message: "Put some message here")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SummaryVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryCell.identifier, for: indexPath) as! SummaryCell
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        106  // image height + paddings (top + bottom) / 110 + 8 + 8
    }
    
    
}


// MARK: - Style & Layout

extension SummaryVC {
    
    func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        payButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Table View
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SummaryCell.self, forCellReuseIdentifier: SummaryCell.identifier)
        
        navigationController?.navigationBar.isHidden = false
        
        payButton.setTitle("Pay", for: .normal)
        payButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        payButton.setTitleColor(.white, for: .normal)
        payButton.backgroundColor = .buttonCustomColor
        payButton.layer.cornerRadius = 6
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        
        
    }
    
    func layout() {
        view.addSubview(tableView)
        view.addSubview(bottomView)
        view.addSubview(payButton)
       
        
        NSLayoutConstraint.activate([
            
            // tableView
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            // bottomView
            bottomView.heightAnchor.constraint(equalToConstant: 200),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            payButton.heightAnchor.constraint(equalToConstant: 50),
            payButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: payButton.trailingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: payButton.bottomAnchor, multiplier: 0.3)
        ])
    }
}

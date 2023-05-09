//
//  ShoppingVC.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 08.05.23.
//

import UIKit

class ShoppingVC: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private let bottomView = ShoppingBottomView()
    private let goToSummaryBtn = UIButton(type: .system)
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(itemCell.self, forCellReuseIdentifier: "cell")
        
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Selectors
    
    @objc func goToSummaryTapped() {
        let vc = SummaryVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ShoppingVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        126
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! itemCell
        
        cell.itemImage.image = UIImage(named: "aaa")
        cell.choosenQuantityLbl.text = "2"
        cell.itemLbl.text = "Apple"
        cell.priceLbl.text = "120"
        cell.itemRemainingLbl.text = "17"
        
        return cell
    }
    
    
}


// MARK: - Style & Layout

extension ShoppingVC {
    
    func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        goToSummaryBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        // button
        goToSummaryBtn.addTarget(self, action: #selector(goToSummaryTapped), for: .touchUpInside)
        
    }
    
    func layout() {
        view.addSubview(tableView)
        bottomView.addSubview(goToSummaryBtn)
        view.addSubview(bottomView)
        
       
        
        NSLayoutConstraint.activate([
            
            // tableView
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            // bottomView
            bottomView.heightAnchor.constraint(equalToConstant: 130),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            
            goToSummaryBtn.topAnchor.constraint(equalTo: bottomView.topAnchor),
            goToSummaryBtn.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            goToSummaryBtn.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            goToSummaryBtn.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)

        ])
        
    }
    
}

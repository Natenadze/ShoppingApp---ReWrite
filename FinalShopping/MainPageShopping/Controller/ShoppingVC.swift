//
//  ShoppingVC.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 08.05.23.
//

import UIKit

class ShoppingVC: UIViewController {
    
    // MARK: - Properties
    let tableView = UITableView()
    let bottomView = ShoppingBottomView()
    let goToSummaryBtn = UIButton(type: .system)
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        style()
        layout()
    }
    
    // MARK: - Selectors
    
    @objc func goToSummaryTapped() {
        print("go to summary")
    }
    
}

extension ShoppingVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    
}


// MARK: - Style & Layout

extension ShoppingVC {
    
    func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        goToSummaryBtn.translatesAutoresizingMaskIntoConstraints = false
        
        navigationController?.navigationBar.isHidden = true
        
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

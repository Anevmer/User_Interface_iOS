//
//  CommunityViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

class CommunityViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Private properties
    
    private var communities: [Entity] = []
    
    // MARK: Public properties
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        initializeSetup()
        applyStyle()
        setupText()
        loadData()
        
    }
        
    // MARK: Private methods
    
    private func initializeSetup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(showSearches))
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let cell = UINib(nibName: "CommunityTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "CommunityTableViewCell")
    }
    
    @objc private func showSearches() {
        let CommunitySearchVC = UIStoryboard(name: "CommunitySearch", bundle: nil).instantiateViewController(withIdentifier: "CommunitySearchViewController") as! CommunitySearchViewController
        
        navigationController?.pushViewController(CommunitySearchVC, animated: true)
    }
}

// MARK: Extension for UITableViewDataSource

extension CommunityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell", for: indexPath) as! CommunityTableViewCell
        let community = communities[indexPath.row]
        cell.configure(withEntity: community)
        return cell
    }
}

// MARK: Extension for UITableViewDelegate

extension CommunityViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("tap", indexPath.row)
    }
}

// MARK: Extension for styling

private extension CommunityViewController {
    func applyStyle() {
        
    }
}

// MARK: Extension for localize

private extension CommunityViewController {
    func setupText() {
        title = "Сообщества"
    }
}

// MARK: Extension for data loading

extension CommunityViewController {
    func loadData() {
        let community1 = CommunityTableCellModel(fullName: "Твой город")
        let community2 = CommunityTableCellModel(fullName: "Фильмы и сериалы")
        
        communities = [community1, community2]
        tableView.reloadData()
    }
}

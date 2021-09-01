//
//  CommunitySearchViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

class CommunitySearchViewController: UIViewController {
    
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
        
    // MARK: Private methods
    
    private func initializeSetup() {
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let cell = UINib(nibName: "CommunityTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "CommunityTableViewCell")
    }
}

// MARK: Extension for UITableViewDataSource

extension CommunitySearchViewController: UITableViewDataSource {
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

extension CommunitySearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("tap", indexPath.row)
    }
}

// MARK: Extension for CommunityTableViewCellDelegate

extension CommunitySearchViewController: CommunityTableViewCellDelegate {
    func communityTableViewCellMoreButton(_ cell: CommunityTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let community = communities[indexPath.row] as! CommunityTableCellModel
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Подписаться", style: .default, handler: { _ in
            self.showActivityIndicator()
            if addedCommunityToMyProfile(withCommunityId: community.id) {
                self.hideActivityIndicator()
                self.loadData()
                print ("success")
            }
            else {
                self.hideActivityIndicator()
                print("error")
            }
        }))
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: Extension for styling

private extension CommunitySearchViewController {
    func applyStyle() {
        
    }
}

// MARK: Extension for localize

private extension CommunitySearchViewController {
    func setupText() {
        title = "Поиск сообществ"
    }
}

// MARK: Extension for data loading

extension CommunitySearchViewController {
    func loadData() {
        let searchesCommunities = getOthersCommunities()
        communities = searchesCommunities.map({CommunityTableCellModel(community: $0, delegate: self)})
        tableView.reloadData()
    }
}

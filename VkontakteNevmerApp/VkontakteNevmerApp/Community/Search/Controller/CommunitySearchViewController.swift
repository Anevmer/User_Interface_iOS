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
    private var searchBar: UISearchBar!
    private var service: CommunityService!
    private var dataSource: CommunitiesTableViewDataSource!
    
    // MARK: Public properties
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeSetup()
        setupTableView()
        applyStyle()
        setupText()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func initializeSetup() {
        service = CommunityServiceImpl()
        dataSource = CommunitiesTableViewDataSource(tableView: tableView)
    }
        
    private func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
        let view = UIView(frame: CGRect(x: 16, y: 10, width: tableView.frame.width - 32, height: 50))
        searchBar = UISearchBar(frame: CGRect(x: 6, y: 0, width: view.frame.width - 16, height: 50))
        searchBar.delegate = self
        searchBar.placeholder = "Найти сообщество"
        searchBar.setImage(UIImage(), for: .clear, state: [])
        searchBar.tintColor = .black
        view.addSubview(searchBar)
        tableView.tableHeaderView = view
        
//        let cell = UINib(nibName: "CommunityTableViewCell", bundle: nil)
//        tableView.register(cell, forCellReuseIdentifier: "CommunityTableViewCell")
    }
}

// MARK: Extension for UISearchBarDelegate

extension CommunitySearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            loadData(withSearchText: searchText)
            searchBar.setShowsCancelButton(true, animated: true)
        }
        else {
            searchBar.setShowsCancelButton(false, animated: true)
            loadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
        loadData()
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
        let community = dataSource.data[indexPath.row] as! CommunityTableCellModel
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Подписаться", style: .default, handler: { _ in
            self.service.joinGroup(groupId: community.id) { [weak self] (response, error) in
                guard let self = self else { return }
                if let error = error {
                    self.showAlert(nil, andAlertMessage: error.errorDescription)
                }
                else {
                    self.navigationController?.popViewController(animated: true)
                }
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
    func loadData(withSearchText searchText: String? = nil) {
        showActivityIndicator()
        service.searchCommunities(searchText: searchText ?? " ") { [weak self] (communities, error) in
            guard let self = self else { return }
            self.hideActivityIndicator()
            if let error = error {
                self.showAlert(nil, andAlertMessage: error.errorDescription)
            }
            else {
                if let communities = communities {
                    self.dataSource.data = communities.map({CommunityTableCellModel($0, delegate: self)})
                }
            }
        }
        
//        var searchesCommunities = getOthersCommunities()
//        if let searchText = searchText {
//            searchesCommunities = searchesCommunities.filter({$0.name.contains(searchText)})
//        }
//        communities = searchesCommunities.map({CommunityTableCellModel(community: $0, delegate: self)})
//        tableView.reloadData()
    }
}

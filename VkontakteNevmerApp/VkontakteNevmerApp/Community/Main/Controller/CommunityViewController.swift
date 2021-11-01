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
    @IBOutlet weak var placeholderView: UIView!
    
    // MARK: Private properties
    
    private var communities: [Entity] = []
    private var service: CommunityService!
    private var dataSource: CommunitiesTableViewDataSource!
    private var loadingView: LoadingView!
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(showSearches))
        service = CommunityServiceImpl()
        dataSource = CommunitiesTableViewDataSource(tableView: tableView)
        loadingView = LoadingView()
        view.addSubview(loadingView)
        loadingView.frame = view.frame
    }
    
    private func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//
        let cell = UINib(nibName: "CommunityTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "CommunityTableViewCell")
    }
    
    @objc private func showSearches() {
        let CommunitySearchVC = UIStoryboard(name: "CommunitySearch", bundle: nil).instantiateViewController(withIdentifier: "CommunitySearchViewController") as! CommunitySearchViewController
        
        navigationController?.pushViewController(CommunitySearchVC, animated: true)
    }
}

// MARK: Extension for UITableViewDataSource

//extension CommunityViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return communities.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell", for: indexPath) as! CommunityTableViewCell
//        let community = communities[indexPath.row]
//        cell.configure(withEntity: community)
//        return cell
//    }
//}

// MARK: Extension for UITableViewDelegate

extension CommunityViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("tap", indexPath.row)
    }
}

// MARK: Extension for CommunityTableViewCellDelegate

extension CommunityViewController: CommunityTableViewCellDelegate {
    func communityTableViewCellMoreButton(_ cell: CommunityTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let community = dataSource.data[indexPath.row] as! CommunityTableCellModel
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Отписаться", style: .destructive, handler: { _ in
            self.service.leaveGroup(groupId: community.id) { [weak self] (response, error) in
                guard let self = self else { return }
                if let error = error {
                    self.showAlert(nil, andAlertMessage: error.errorDescription)
                }
                else {
                    self.loadData()
                }
            }
        }))
        present(alertController, animated: true, completion: nil)
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
        showActivityIndicator()
        service.getCommunities { [weak self] (communities, error) in
            guard let self = self else { return }
            self.hideActivityIndicator()
            if let error = error {
                self.showAlert(nil, andAlertMessage: error.errorDescription)
            }
            else {
                if let communities = communities {
                    self.placeholderView.isHidden = communities.count != 0
                    self.dataSource.data = communities.map({CommunityTableCellModel($0, delegate: self)})
                }
            }
        }
        
//        let myCommunities = getMyCommunities()
//        communities = myCommunities.map({CommunityTableCellModel(community: $0, delegate: self)})
//        placeholderView.isHidden = communities.count != 0
//        tableView.reloadData()
    }
}

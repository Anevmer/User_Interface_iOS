//
//  FriendsViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

class FriendsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Private properties
    
    private var friends: [Entity] = []
    
    // MARK: Public properties
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeSetup()
        setupTableView()
        applyStyle()
        setupText()
        loadData()
        
    }
    
    // MARK: Actions
    
    // MARK: Private methods
    
    private func initializeSetup() {
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let cell = UINib(nibName: "FriendTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "FriendTableViewCell")
    }
}

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as! FriendTableViewCell
        let friend = friends[indexPath.row]
        cell.configure(withEntity: friend)
        
        return cell
    }

}

extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friends[indexPath.row] as! FriendTableCellModel
        let friendPhotoVC = UIStoryboard(name: "FriendPhotos", bundle: nil).instantiateViewController(withIdentifier: "FriendPhotosViewController") as! FriendPhotosViewController
        friendPhotoVC.fullName = friend.fullName
        navigationController?.pushViewController(friendPhotoVC, animated: true)
    }
}

// MARK: Extension for styling

private extension FriendsViewController {
    func applyStyle() {
        
    }
}

// MARK: Extension for localize

private extension FriendsViewController {
    func setupText() {
        title = "Друзья"
    }
}

// MARK: Extension for data loading

extension FriendsViewController {
    func loadData() {
        let friend = FriendTableCellModel(fullName: "Иванов Иван")
        
        friends = [friend,friend,friend]
        tableView.reloadData()
    }
}

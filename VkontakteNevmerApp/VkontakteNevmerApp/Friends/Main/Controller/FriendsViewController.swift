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
    @IBOutlet weak var myFriendsButton: UIButton!
    @IBOutlet weak var searchFriendsButton: UIButton!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var bottomLineLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLineWidthConstraint: NSLayoutConstraint!
    
    // MARK: Private properties

    private var isMyFriendSelected: Bool = true
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
    
    @IBAction func myFriendsButtonTapped(_ sender: UIButton) {
        bottomViewMoveToButton(button: sender)
    }
    
    @IBAction func searchFriendsButtonTapped(_ sender: UIButton) {
        bottomViewMoveToButton(button: sender)
    }
    
    // MARK: Private methods
    
    private func initializeSetup() {
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let cell = UINib(nibName: "FriendTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "FriendTableViewCell")
    }
    
    private func bottomViewMoveToButton(button: UIButton) {
        switch button {
        case myFriendsButton:
            myFriendsButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            searchFriendsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            myFriendsButton.setTitleColor(.black, for: .normal)
            searchFriendsButton.setTitleColor(.gray, for: .normal)
            bottomLineWidthConstraint.constant = myFriendsButton.frame.width
            isMyFriendSelected = true
        case searchFriendsButton:
            myFriendsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            searchFriendsButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            myFriendsButton.setTitleColor(.gray, for: .normal)
            searchFriendsButton.setTitleColor(.black, for: .normal)
            bottomLineWidthConstraint.constant = myFriendsButton.frame.width
            isMyFriendSelected = false
        default: break
        }
        if let frame = button.superview?.frame {
            let superViewFrameX = frame.minX
            let frameX = button.frame.minX
            bottomLineLeadingConstraint.constant = superViewFrameX + frameX
            UIView.animate(withDuration: 0.4) {
                self.view.layoutIfNeeded()
            }
        }
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
        friendPhotoVC.user = friend.user
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
        let  me = getMyProfile()
        navigationItem.title = me?.name
        let myFriends = getMyFriends()
        self.friends = myFriends.map({FriendTableCellModel(user: $0)})
        
        tableView.reloadData()
    }
}

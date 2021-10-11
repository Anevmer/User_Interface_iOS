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
    @IBOutlet weak var myFriendsButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchFriendsButtonWidthConstraint: NSLayoutConstraint!
    
    // MARK: Private properties

    private var isMyFriendSelected: Bool = true
//    private var selectedUs
    private var myFriends: [Entity] = []
    private var groupedUsers: [Int: [Entity]] = [:]
    private var sectionTitles: [String] = []
    private var service: FriendsService!
    
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
        service = FriendsServiceImpl()
//        bottomViewMoveToButton(button: myFriendsButton)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        tableView.tableHeaderView = headerView
        
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
            bottomLineWidthConstraint.constant = myFriendsButtonWidthConstraint.constant
            isMyFriendSelected = true
        case searchFriendsButton:
            myFriendsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            searchFriendsButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            myFriendsButton.setTitleColor(.gray, for: .normal)
            searchFriendsButton.setTitleColor(.black, for: .normal)
            bottomLineWidthConstraint.constant = searchFriendsButtonWidthConstraint.constant
            isMyFriendSelected = false
            
        default: break
        }
        if let frame = button.superview?.frame {
            let superViewFrameX = frame.minX
            let frameX = button.frame.minX
            view.layoutIfNeeded()
            bottomLineLeadingConstraint.constant = superViewFrameX + frameX + 16
            UIView.animate(withDuration: 0.4) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension FriendsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
//        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = groupedUsers[section] {
            return items.count
        }

        return 0

//        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let items = groupedUsers[indexPath.section] else {
            return UITableViewCell()
            
        }
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as! FriendTableViewCell
        cell.configure(withEntity: item)
        
        return cell

    }
}

extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let items = groupedUsers[indexPath.section] {
            let friend = items[indexPath.row] as! FriendTableCellModel
            let friendPhotoVC = UIStoryboard(name: "FriendPhotos", bundle: nil).instantiateViewController(withIdentifier: "FriendPhotosViewController") as! FriendPhotosViewController
            friendPhotoVC.user = friend.user
            navigationController?.pushViewController(friendPhotoVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 38))
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 12, width: headerView.frame.width - 32, height: headerView.frame.height - 12))
        headerView.backgroundColor = .white50
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titleLabel.text = sectionTitles[section]
        headerView.addSubview(titleLabel)

        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 60
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
        
        service.getFriends { [weak self] (response, error) in
            guard let self = self else { return }
            if let error = error {
                self.showAlert(nil, andAlertMessage: error.errorDescription)
            }
            else {
                if let response = response {
                    
                }
            }
        }
 
        let  me = getMyProfile()
        navigationItem.title = me?.name
        let friends = getMyFriends()
        
        self.myFriends = friends.map{FriendTableCellModel(user: $0)}
        var characters: [String.Element] = []
        self.sectionTitles.removeAll()
        
        for friend in friends {
            if let firstSurnameCharacter = friend.surname.first {
                if !characters.contains(firstSurnameCharacter) {
                    characters.append(firstSurnameCharacter)
                }
            }
        }
        
        characters.sort { $0 < $1 }
        
        var i = 0
        var groupedUsers: [Int: [Entity]] = [:]
        while i < characters.count {
            let character = characters[i]
            var characterUsers: [Entity] = []
            for friend in friends {
                if let userCharacter = friend.surname.first, userCharacter == character {
                    characterUsers.append(FriendTableCellModel(user: friend))
                }
            }
            groupedUsers[i] = characterUsers
            self.sectionTitles.append(String.init(character))
            i += 1
        }
        
        self.groupedUsers = groupedUsers
        tableView.reloadData()
    }
}

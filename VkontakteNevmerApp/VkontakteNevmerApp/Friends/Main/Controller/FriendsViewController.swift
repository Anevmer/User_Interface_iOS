//
//  FriendsViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit
import CollectionAndTableViewCompatible
import RealmSwift

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
//    private var myFriends: [Entity] = []
    private var groupedUsers: [Int: [Entity]] = [:]
    private var sectionTitles: [String] = []
    private var service: FriendsService!
    private var myFriends: [TableViewCompatible] = []
    private var dataSource: FriendsTableViewDataSource!
    private var loadingView: LoadingView!
    
    // MARK: Public properties
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeSetup()
        setupTableView()
        applyStyle()
        setupText()
        updateFriends()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        dataSource = FriendsTableViewDataSource(tableView: tableView)
        loadingView = LoadingView()
        view.addSubview(loadingView)
        loadingView.frame = view.frame
//        bottomViewMoveToButton(button: myFriendsButton)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        tableView.tableHeaderView = headerView
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

extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let items = dataSource.dataWithSections[indexPath.section] {
            let friend = items[indexPath.row] as! FriendTableCellModel
            let friendPhotoVC = UIStoryboard(name: "FriendPhotos", bundle: nil).instantiateViewController(withIdentifier: "FriendPhotosViewController") as! FriendPhotosViewController
            friendPhotoVC.userId = friend.id
            navigationController?.pushViewController(friendPhotoVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 38))
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 12, width: headerView.frame.width - 32, height: headerView.frame.height - 12))
        headerView.backgroundColor = .white50
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titleLabel.text = dataSource.sectionTitles[section]
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

        do {
            let friends = try RealmService.load(typeOf: FriendRealmModel.self)
            self.dataSource.data = friends.map({ FriendTableCellModel(realmFriend: $0)})
        } catch {
            self.showAlert(nil, andAlertMessage: error.localizedDescription)
        }
    }
    
    func updateFriends() {
        showActivityIndicator()
        service.getFriends { [weak self] (friends, error) in
            guard let self = self else { return }
            self.hideActivityIndicator()
            if let error = error {
                self.showAlert(nil, andAlertMessage: error.errorDescription)
            }
            else {
                if let friends = friends, friends.count > 0 {
                    self.loadData()
                }
            }
        }
    }
}

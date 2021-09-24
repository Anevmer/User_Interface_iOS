//
//  NewsViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 08.09.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var subscribesButton: UIButton!
    @IBOutlet weak var subscribesButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var friendsButton: UIButton!
    @IBOutlet weak var friendsButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var recommendationsButton: UIButton!
    @IBOutlet weak var recommendationsButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var bottomLineViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLineViewLeadingConstraint: NSLayoutConstraint!
    
    // MARK: Private properties
    
    private var news: [Entity] = []
    private var selectedIndex = 0
    
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
        loadData()
    }
    
    // MARK: Actions
    
    @IBAction func selectGroupButtonTapped(_ sender: UIButton) {
        setupBottomLineView(sender)
    }

    // MARK: Private methods
    
    private func initializeSetup() {
        
    }
    
    private func setupBottomLineView(_ sender: UIButton) {
        view.layoutIfNeeded()
        switch sender {
        case subscribesButton:
            selectedIndex = 0
            subscribesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            friendsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            recommendationsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        case friendsButton:
            selectedIndex = 1
            subscribesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            friendsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            recommendationsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        case recommendationsButton:
            selectedIndex = 2
            subscribesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            friendsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            recommendationsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        default:
            break
        }
        let stackFrameX = stackView.frame.minX
        let buttonFrameX = sender.frame.minX
        bottomLineViewLeadingConstraint.constant = stackFrameX + buttonFrameX
        bottomLineViewWidthConstraint.constant = sender.frame.width
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
//        print (scrollViewFrame, scrollViewFrameX, stackViewFrame, stackFrameX)
        loadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "NewsModelTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsModelTableViewCell")
    }
    
}

// MARK: Extension for UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsModelTableViewCell", for: indexPath) as! NewsModelTableViewCell
        let newsModel = news[indexPath.row]
        cell.delegate = self
        cell.configure(entity: newsModel)
        
        return cell
    }
}

// MARK: Extension for UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    
}

// MARK: Extension for UITableViewDelegate

extension NewsViewController: NewsModelTableViewCellDelegate {
    func newsModelTableViewCell(_ cell: NewsModelTableViewCell, isLiked: Bool) {
//        let news = news as! [NewsTableCellModel]
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        if let news = news as? [NewsTableCellModel] {
            let new = news[indexPath.row]
            guard let newIndex = news.firstIndex(where: {$0.newId == new.newId}) else { return }
            setIsLikeForNew(isLike: isLiked, to: new.newId)
            new.isLiked = isLiked
            if isLiked {
                new.likesCount += 1
            }
            else {
                new.likesCount -= 1
            }
            self.news[newIndex] = new
        }
        
        tableView.reloadData()
    }
}
 
// MARK: Extension for styling

private extension NewsViewController {
    func applyStyle() {
        subscribesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        friendsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        recommendationsButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        let stackFrameX = stackView.frame.minX
        let buttonFrameX = subscribesButton.frame.minX
        bottomLineViewLeadingConstraint.constant = stackFrameX + buttonFrameX
        bottomLineViewWidthConstraint.constant = subscribesButton.frame.width
    }
}

// MARK: Extension for localize

private extension NewsViewController {
    func setupText() {
        title = "Новости"
    }
}

// MARK: Extension for data loading

extension NewsViewController {
    func loadData() {
        if let myProfile = getMyProfile() {
            switch selectedIndex {
            case 0:
                news = getMySubscribesNew().map({NewsTableCellModel(newsModel: $0, myProfileId: myProfile.id)})
            case 1:
                news = getMyFriendNew().map({NewsTableCellModel(newsModel: $0, myProfileId: myProfile.id)})
            case 2:
                news = getOtherNews().map({NewsTableCellModel(newsModel: $0, myProfileId: myProfile.id)})
            default:
                news = getAllNews().map({NewsTableCellModel(newsModel: $0, myProfileId: myProfile.id)})
            }
            tableView.reloadData()
        }
    }
}

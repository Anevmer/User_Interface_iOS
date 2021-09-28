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
    
    // MARK: Private properties
    
    private var news: [Entity] = []
    
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
    
    // MARK: Actions
    
    // MARK: Private methods
    
    private func initializeSetup() {
        
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
        cell.configure(entity: newsModel)
        
        return cell
    }
}

// MARK: Extension for UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    
}

// MARK: Extension for styling

private extension NewsViewController {
    func applyStyle() {
        
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
        news = getAllNews().map({NewsTableCellModel(newsModel: $0)})
        tableView.reloadData()
    }
}

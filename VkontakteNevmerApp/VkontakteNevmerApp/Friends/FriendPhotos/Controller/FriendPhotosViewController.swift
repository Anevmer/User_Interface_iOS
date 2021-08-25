//
//  FriendPhotosViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

class FriendPhotosViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Private properties
    
    private var userPhotos: [Entity] = []
    
    // MARK: Public properties
    
    var fullName: String?
    var user: UserProfile?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupCollectionView()
    }
    
    // MARK: Private methods
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "UserPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserPhotoCollectionViewCell")
    }
}

extension FriendPhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let photos = user?.photoNames else { return 0 }
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserPhotoCollectionViewCell", for: indexPath) as! UserPhotoCollectionViewCell
        let photo = userPhotos[indexPath.item]
        cell.configure(withEntity: photo)
        
        return cell
    }
 
}

// MARK: Extension for data loading

extension FriendPhotosViewController {
    func loadData() {
        if let user = user {
            title = user.name + " " + user.surname
            userPhotos = user.photoNames.map({UserPhotoCollectionCellModel(photoName: $0)})
            collectionView.reloadData()
        }
    }
}


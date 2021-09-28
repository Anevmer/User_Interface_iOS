//
//  FriendPhotosViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

class FriendPhotosViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var lastOnlineLabel: UILabel!
    @IBOutlet weak var friendActionButton: SecondaryButton!
    @IBOutlet weak var photoLabel: UILabel!
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
        collectionView.delegate = self
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

extension FriendPhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let viewerVC = UIStoryboard(name: "PhotoViewer", bundle: nil).instantiateViewController(withIdentifier: "PhotoViewerViewController") as! PhotoViewerViewController
        viewerVC.photos = user?.photoNames ?? []
        viewerVC.currentImageNumber = indexPath.item
        viewerVC.modalPresentationStyle = .fullScreen
        
        present(viewerVC, animated: true, completion: nil)
//        navigationController?.pushViewController(viewerVC, animated: true)
    }
}

// MARK: Extension for data loading

extension FriendPhotosViewController {
    func loadData() {
        if let user = user {
            fullNameLabel.text = user.name + " " + user.surname
            avatarImageView.image = UIImage(named: user.avatarName)
            lastOnlineLabel.text = "Был в сети давно..."
            photoLabel.text = "ФОТОГРАФИИ \(user.photoNames.count)"
            userPhotos = user.photoNames.map({UserPhotoCollectionCellModel(photoName: $0)})
//            placeholderView.isHidden = userPhotos.count == 0 ? false : true
            collectionView.reloadData()
        }
    }
}


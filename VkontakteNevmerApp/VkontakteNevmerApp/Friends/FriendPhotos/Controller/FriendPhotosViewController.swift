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
    private var service: FriendsService!
    private var photoDataSource: UserPhotoCollectionViewDataSource!
    
    // MARK: Public properties
    
    var fullName: String?
    var userId: Int?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSetup()
        loadData()
    }
    
    // MARK: Private methods
    
    private func initializeSetup() {
        service = FriendsServiceImpl()
        photoDataSource = UserPhotoCollectionViewDataSource(collectionView: collectionView)
        collectionView.delegate = self
    }
}

extension FriendPhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let viewerVC = UIStoryboard(name: "PhotoViewer", bundle: nil).instantiateViewController(withIdentifier: "PhotoViewerViewController") as! PhotoViewerViewController
//        viewerVC.photos = user?.photoNames ?? []
//        viewerVC.currentImageNumber = indexPath.item
//        viewerVC.modalPresentationStyle = .fullScreen
//        
//        present(viewerVC, animated: true, completion: nil)
//        navigationController?.pushViewController(viewerVC, animated: true)
    }
}

// MARK: Extension for data loading

extension FriendPhotosViewController {
    func loadData() {
        showActivityIndicator()
        guard let userId = userId else { return }
        service.getAllPhotoFor(ownerId: userId) { [weak self] (photos, error) in
            guard let self = self else { return }
            self.hideActivityIndicator()
            if let error = error {
                self.showAlert(nil, andAlertMessage: error.errorDescription)
            }
            else {
                if let photos = photos {
                    
                }
            }
        }
//        if let user = user {
//            fullNameLabel.text = user.name + " " + user.surname
//            avatarImageView.image = UIImage(named: user.avatarName)
//            lastOnlineLabel.text = "Был в сети давно..."
//            photoLabel.text = "ФОТОГРАФИИ \(user.photoNames.count)"
//            userPhotos = user.photoNames.map({UserPhotoCollectionCellModel(photoName: $0)})
//            placeholderView.isHidden = userPhotos.count == 0 ? false : true
//            collectionView.reloadData()
//        }
    }
}


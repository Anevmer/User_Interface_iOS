//
//  PhotoViewerViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 16.09.2021.
//

import UIKit

class PhotoViewerViewController: UIViewController {
    
    // MARK: Outlets
        
    // MARK: Public properties
    
    var photos: [String] = []
    var currentImageNumber: Int?
    
    // MARK: Private properties
    
    // MARK: Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Private methods
    
    private func setupView() {
        let viewBounds = self.view.bounds
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: viewBounds.width, height: viewBounds.height))
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        var xPosition: CGFloat = 0

        for photo in photos {
            let view = UIView(frame: CGRect(x: xPosition, y: 0, width: viewBounds.width, height: viewBounds.height))
            xPosition += viewBounds.width
            let imageView = ImageViewZoom(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            
            imageView.setup()
            imageView.imageScrollViewDelegate = self
            imageView.imageContentMode = .aspectFit
            imageView.initialOffset = .center
            imageView.display(image: UIImage(named: photo)!)
            
            view.addSubview(imageView)
            scrollView.addSubview(view)
        }
        
        let button = UIButton(frame: CGRect(x: 30, y: 60, width: 50, height: 50))
        button.layer.cornerRadius = 25
        button.setTitle("X", for: [])
        button.setTitleColor(.black, for: [])
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .white50
        button.addAction(UIAction(handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
        
        scrollView.contentSize = CGSize(width: xPosition, height: viewBounds.height)
        self.view.addSubview(scrollView)
        self.view.addSubview(button)
        if let currentImage = currentImageNumber {
            let currentPhotoRect = CGFloat(currentImage + 1) * viewBounds.width
            scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: currentPhotoRect, height: viewBounds.height), animated: true)
        }
    }
}

// MARK: Extension for ImageViewZoomDelegate

extension PhotoViewerViewController: ImageViewZoomDelegate {
    func imageScrollViewDidChangeOrientation(imageViewZoom: ImageViewZoom) {
        print("Did change orientation")
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print("scrollViewDidEndZooming at scale \(scale)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll at offset \(scrollView.contentOffset)")
    }
}

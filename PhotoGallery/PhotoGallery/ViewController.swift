//
//  ViewController.swift
//  PhotoGallery
//
//  Created by 주효진 on 2022/09/13.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photo Gallery"
        makeNavigationItem()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 1) / 2, height: 200)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        photoCollectionView.collectionViewLayout = layout
        
        photoCollectionView.dataSource = self
        
    }
    
    func makeNavigationItem() {
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle"), style: .done, target: self, action: #selector(checkPermission))
        photoItem.tintColor = .black.withAlphaComponent(0.7)
        self.navigationItem.rightBarButtonItem = photoItem
        
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refresh))
        refreshItem.tintColor = .red.withAlphaComponent(0.7)
        self.navigationItem.leftBarButtonItem = refreshItem
    }
    
    @objc func checkPermission() {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            
        }
        
        showGallery()
    }
    
    func showGallery() {
        let library = PHPhotoLibrary.shared()
        var configuration = PHPickerConfiguration(photoLibrary: library)
        configuration.selectionLimit = 10
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    @objc func refresh() {
        
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        
        return cell
    }
    
    
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

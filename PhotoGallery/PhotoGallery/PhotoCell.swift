//
//  PhotoCell.swift
//  PhotoGallery
//
//  Created by 주효진 on 2022/09/14.
//

import UIKit
import PhotosUI

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    func loadImage(asset: PHAsset) {
        let imageManager = PHImageManager()
        let scale = UIScreen.main.scale
        let imageSize = CGSize(width: 150 * scale, height: 150 * scale)
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        
        self.photoImageView.image = nil
        
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: options) { image, info in
            
//            if(info?[PHImageResultIsDegradedKey] as? Bool) == true {
//                // 저화질
//            } else {
//                // 고화질
//            }
            
            self.photoImageView.image = image
        }
    }
    
}

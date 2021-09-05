//
//  CollectionViewCell.swift
//  SplashSplash
//
//  Created by Sergei Krupenikov on 29.08.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func setup(with photo: Photo) {
        NetworkService.shared.getImage(for: photo.urls.small) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.imageView.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
        label.text = String(photo.likes) + "♡"
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        
        super.prepareForReuse()
    }
}

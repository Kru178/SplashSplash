//
//  DetailViewController.swift
//  SplashSplash
//
//  Created by Sergei Krupenikov on 31.08.2021.
//

import UIKit
import CoreGraphics


class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    var id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let id = id else { return }
        loadPhoto(for: id)
    }
    
    func loadPhoto(for id: String) {
        
        let url = "https://api.unsplash.com/photos/\(id)?client_id=Pkvb5nstXnk5pT7MTu4-wamJkLNlNe0Ok43JBZn6Tzk"
        
        NetworkService.shared.getPhoto(for: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photo):
                DispatchQueue.main.async {
                    self.loadImage(for: photo.urls.regular)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadImage(for url: String) {
        NetworkService.shared.getImage(for: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.detailImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func actionPressed(_ sender: UIBarButtonItem) {
        
        guard let image = detailImageView.image else { return }
        let ac = UIAlertController(title: "Save", message: "Do you want to save this photo to your photo album?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
}

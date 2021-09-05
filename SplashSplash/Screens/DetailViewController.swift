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
//    @IBOutlet weak var slider: UISlider!
//
//    var context: CIContext!
//    var currentFilter: CIFilter!
    var id: String?
//    var currentImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(id!)
        loadPhoto(for: id!)
//        context = CIContext()
//        currentFilter = CIFilter(name: "CISepiaTone")
    }
    
    func loadPhoto(for id: String) {
        
        let url = "https://api.unsplash.com/photos/\(id)?client_id=Pkvb5nstXnk5pT7MTu4-wamJkLNlNe0Ok43JBZn6Tzk"
        
        NetworkService.shared.getPhoto(for: url) { result in
            
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
        NetworkService.shared.getImage(for: url) { result in
            
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
    
//    func edit() {
//        slider.isEnabled = true
//        let beginImage = CIImage(image: detailImageView.image!)
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//
//        applyProcessing()
//    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let image = info[.editedImage] as? UIImage else { return }
//
//        dismiss(animated: true)
//
//        currentImage = image
//    }

    @IBAction func actionPressed(_ sender: UIBarButtonItem) {
        
        let ac = UIAlertController(title: "Save", message: "Do you want to save this photo to your photo album?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            UIImageWriteToSavedPhotosAlbum(self.detailImageView.image!, self, nil, nil)
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
//    @IBAction func changeFilterPressed(_ sender: UIButton) {
//        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
//            ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
//            ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
//            ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
//            ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
//            ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
//            ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
//            ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
//            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//            present(ac, animated: true)
//    }
    
//    @IBAction func editButtonPressed(_ sender: UIButton) {
//        edit()
//    }
//
//    @IBAction func sliderMoved(_ sender: UISlider) {
//        applyProcessing()
//    }
    
//    func applyProcessing() {
//        let inputKeys = currentFilter.inputKeys
//
//            if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(slider.value, forKey: kCIInputIntensityKey) }
//            if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(slider.value * 200, forKey: kCIInputRadiusKey) }
//            if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(slider.value * 10, forKey: kCIInputScaleKey) }
//            if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }
//
//            if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
//                let processedImage = UIImage(cgImage: cgimg)
//                self.detailImageView.image = processedImage
//            }
//    }
//
//    func setFilter(action: UIAlertAction) {
//        slider.isEnabled = true
//
//        // make sure we have a valid image before continuing!
//        guard currentImage != nil else { return }
//
//        // safely read the alert action's title
//        guard let actionTitle = action.title else { return }
//
//        currentFilter = CIFilter(name: actionTitle)
//
//        let beginImage = CIImage(image: currentImage)
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//
//        applyProcessing()
//    }
}

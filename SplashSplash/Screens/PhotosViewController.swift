//
//  PhotosViewController.swift
//  SplashSplash
//
//  Created by Sergei Krupenikov on 21.08.2021.
//

import UIKit

class PhotosViewController: UICollectionViewController {
    
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    var photos = [Photo]()
    var text = String()
    var page = 1
    var totalPages = 1
    var isLoading = false
    var selectedID: String?
    var currentOrder = Sort.latest {
        didSet {
            self.photos.removeAll()
            self.loadPhotos(for: self.text, order: self.currentOrder, page: self.page)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = text
        view.backgroundColor = .blue
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .cyan
        loadPhotos(for: text, order: currentOrder, page: page)
        collectionView.collectionViewLayout = UIHelper.createTwoColumnFlowLayout(in: view)
        collectionView.alwaysBounceVertical = true
    }
    
    func loadPhotos(for word: String, order: String, page: Int) {
        isLoading = true
        NetworkService.shared.getPhotos(for: word, page: page, order: order) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    self.photos += list.results
                    self.totalPages = list.totalPages
                    self.collectionView.reloadSections(IndexSet(integer: 0))
                case .failure(let error):
                    print(error)
                }
                self.isLoading = false
            }
        }
    }
    
    // MARK: - Collection View DataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! CollectionViewCell
        
        cell.setup(with: photos[indexPath.row])
        return cell
    }
    
    // MARK: - Collection View Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedID = photos[indexPath.item].id
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailViewController
        detailVC?.id = selectedID
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard page <= totalPages, !isLoading else { return }
            page += 1
            loadPhotos(for: text, order: currentOrder, page: page)
        }
    }

    @IBAction func sortPressed(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Latest", style: .default, handler: { action in
            self.currentOrder = Sort.latest
            self.page = 1
        }))
        ac.addAction(UIAlertAction(title: "Oldest", style: .default, handler: { action in
            self.currentOrder = Sort.oldest
            self.page = 1
        }))
        ac.addAction(UIAlertAction(title: "Popular", style: .default, handler: { action in
            self.currentOrder = Sort.popular
            self.page = 1
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
}

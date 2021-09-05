//
//  NetworkService.swift
//  SplashSplash
//
//  Created by Sergei Krupenikov on 22.08.2021.
//

import Foundation
import UIKit

class NetworkService {
    
    static let shared = NetworkService()
    private let unsplshBaseUrl = "https://api.unsplash.com/"
    private let apiKey = "&client_id=Pkvb5nstXnk5pT7MTu4-wamJkLNlNe0Ok43JBZn6Tzk"
    
//    private let flckrBaseUrl = "https://api.flickr.com/services/search?"
    
    func getPhotos(for name: String, page: Int, order: String, completed: @escaping (Result<PhotosList, SSError>) -> Void) {
    let end = "search/photos?page=\(page)&per_page=20&query=\(name)"
    let endpoint = unsplshBaseUrl + end + "&order_by=\(order)" + apiKey
        
//        let endpoint = flckrBaseUrl + name
//        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let photos = try decoder.decode(PhotosList.self, from: data)
                completed(.success(photos))
            }
            catch {
                print(error)
                completed(.failure(.decoderFail))
            }
        }
        task.resume()
    }
    
    func getPhoto(for url: String, completed: @escaping (Result<Photo, SSError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let photo =  try decoder.decode(Photo.self, from: data)
                completed(.success(photo))
            }
            catch {
                print(error)
                completed(.failure(.decoderFail))
            }
        }
        task.resume()
        
    }
    
    func getImage(for url: String, completed: @escaping (Result<UIImage, SSError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            let image = UIImage(data: data)
            completed(.success(image!))
        })
        task.resume()
    }
    
}

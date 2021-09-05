//
//  Model.swift
//  SplashSplash
//
//  Created by Sergei Krupenikov on 22.08.2021.
//

import Foundation

struct PhotosList: Codable {
    var total: Int
    var totalPages: Int
    var results: [Photo]
}

struct Photo: Codable {
    var id: String
    var likes: Int
    var urls: Urls
}

struct Urls: Codable {
    var regular: String
    var small: String
}

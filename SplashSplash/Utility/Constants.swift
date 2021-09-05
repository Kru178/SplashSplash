//
//  Constants.swift
//  SplashSplash
//
//  Created by Sergei Krupenikov on 04.09.2021.
//

import Foundation

enum Sort {
    static let latest = "latest"
    static let relevant = "relevant"
    static let landscape = "landscape"
    static let portrait = "portrait"
    static let squarish = "squarish"
}

enum Segue {
    static let toPhotos = "toPhotos"
    static let toDetail = "toDetail"
}

enum CellReuseIdentifier {
    static let photoCell = "photoCell"
}

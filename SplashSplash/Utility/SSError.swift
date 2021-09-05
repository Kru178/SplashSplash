//
//  SSError.swift
//  SplashSplash
//
//  Created by Sergei Krupenikov on 22.08.2021.
//

import Foundation

enum SSError: String, Error {
    
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid."
    case decoderFail = "Can't decode the data"
}

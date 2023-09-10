//
//  ImageStorageService.swift
//  ArcaneShareExtension
//
//  Created by Rohit Sharma on 02/09/23.
//

import Foundation
import UIKit

protocol ImageStorage {
    func insertImage(image: UIImage)
    func retrieveImages() -> [Data]
}

class UserDefaultsImageStorageService: ImageStorage {
    private let key: String
    init(key: String) {
        self.key = key
    }
    func insertImage(image: UIImage) {
        let defaults = UserDefaults(suiteName: "group.Rohit.app")
        if let imageData = image.pngData() {
            var storedImages = retrieveImages()
           storedImages.append(imageData)
           defaults?.set(storedImages, forKey: key)
        }
    }
    
    func retrieveImages() -> [Data] {
        var images: [Data] = []
        let defaults = UserDefaults(suiteName: "group.Rohit.app")
        if let imageData = defaults?.array(forKey: key) as? [Data] {
            return imageData
        } else {
            return images
        }
    }
}

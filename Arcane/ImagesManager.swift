//
//  ImagesManager.swift
//  Arcane
//
//  Created by Rohit Sharma on 02/09/23.
//

import Foundation
import UIKit
class ImagesManager {
    let assetNames = ["1","2","3","4","5","6","7","8","9","10","11"]
    let imageStorageService: ImageStorage = UserDefaultsImageStorageService(key: "images")
    func fetchImages() -> [UIImage]{
        var images: [UIImage] = []
        for item in assetNames {
            if let image = UIImage(named: item){
                images.append(image)
            }
        }
        for each in loadAdditionalImages() {
            images.append(each)
        }
        return images
    }
    func loadAdditionalImages() -> [UIImage] {
        return imageStorageService.retrieveImages().compactMap{UIImage(data: $0)}
    }
}

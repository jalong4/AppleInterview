//
//  Video.swift
//  AppleInterview
//
//  Created by Jim Long on 12/21/17.
//  Copyright © 2017 Jim Long. All rights reserved.
//

import UIKit

enum Provider: String {
    case apple
    case hbo
    case amazon
    case unknown
}

class Video {
    
    static let imageCache = NSCache<NSString, NSData>()
    
    var title: String
    var imageUrl: String
    var provider = Provider.unknown
    
    init(json: [String: String]) {
        title = json["title"] ?? ""
        imageUrl = json["imageUrl"] ?? ""
        if let s = json["provider"], let provider = Provider(rawValue: s) {
            self.provider = provider
        }
    }
    
    func getImage(completion: (UIImage?) -> ()){
        
        if let cachedData = Video.imageCache.object(forKey: imageUrl as NSString) as Data? {
            let image = UIImage(data: cachedData)
            completion(image)
            return
        }
        
        switch provider {
        case Provider.apple:
            // apple code to get url
            let image = #imageLiteral(resourceName: "apple")
            if let data = UIImagePNGRepresentation(image) as NSData? {
                Video.imageCache.setObject(data, forKey: imageUrl as NSString)
            }
            //  replace code above with code to get image from Apple
            completion(image)
        case Provider.hbo:
            // hbo code to get url
            let image = #imageLiteral(resourceName: "hbo")
            if let data = UIImagePNGRepresentation(image) as NSData? {
                Video.imageCache.setObject(data, forKey: imageUrl as NSString)
            }
            //  replace code above with code to get image from HBO
            completion(image)
        case Provider.amazon:
            // amazon code to get url
            let image = #imageLiteral(resourceName: "amazon")
            if let data = UIImagePNGRepresentation(image) as NSData? {
                Video.imageCache.setObject(data, forKey: imageUrl as NSString)
            }
            //  replace code above with code to get image from Amazon
            completion(image)
        case Provider.unknown:
            completion(nil)
        }
    }
}

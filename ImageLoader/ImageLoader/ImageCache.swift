//
//  ImageCache.swift
//  ImageLoader
//
//  Created by 1293 on 2020/5/15.
//  Copyright © 2020 maja. All rights reserved.
//

import Foundation
import SwiftUI

class Cacher {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension Cacher {
    private static var imageCache = Cacher()
    static func getImageCache() -> Cacher {
        return imageCache
    }
}

//
//  Cacher.swift
//
//
//  Created by 1293 on 2020/5/15.
//  Copyright © 2020 maja. All rights reserved.
//

import Foundation
import SwiftUI

class Cacher {
    var cache = NSCache<NSString, AnyObject>()
    
    func get(forKey: String) -> AnyObject? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, data: AnyObject) {
        cache.setObject(data, forKey: NSString(string: forKey))
    }
}

extension Cacher {
    private static var shared = Cacher()
    static func getCache() -> Cacher {
        return shared
    }
}

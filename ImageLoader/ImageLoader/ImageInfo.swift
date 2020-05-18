//
//  ImageInfo.swift
//  ImageLoader
//
//  Created by 1293 on 2020/5/14.
//  Copyright © 2020 maja. All rights reserved.
//

/**
 "id": "0",
 "author": "Alejandro Escamilla",
 "width": 5616,
 "height": 3744,
 "url": "https://unsplash.com/photos/yC-Yzbqy7PY",
 "download_url": "https://picsum.photos/id/0/5616/3744"

 
 */

import Foundation

struct ImageInfo: Codable, Identifiable {
    
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: URL
    let downloadUrl: URL
}


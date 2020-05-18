//
//  Remote.swift
//  ImageLoader
//
//  Created by 1293 on 2020/5/14.
//  Copyright © 2020 maja. All rights reserved.
//

import Foundation
import SwiftUI

enum NetworkError: Error {
    case loadingError
}

class Remote<Type>: ObservableObject {
    let url: URL
    let transform: (Data) -> Type?
    var task: URLSessionDataTask?
    // Image list
    @Published var data: Result<Type, Error>?
    
    var value: Type? {
        try? data?.get()
    }
    
    init(url: URL, transform: @escaping (Data) -> Type? ) {
        self.url = url
        self.transform = transform
    }

    
    /**
     Load function
     */
    func load(){
        
        if value != nil {
            return
        }
        
        if task == nil {
            self.task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let d = data, let v = self.transform(d) {
                        print("remote")
                        if Type.self == UIImage.self {
                            Cacher.getCache().set(forKey: self.url.absoluteString, data: d as AnyObject)
                        }
                        
                        self.data = .success(v)
                    } else {
                        self.data = .failure(NetworkError.loadingError)
                    }
                }
            }
        }
        
        if Type.self == UIImage.self {
            if let data = Cacher.getCache().get(forKey: url.absoluteString) as? Data {
                if let value = self.transform(data) {
                    /// Set value
                    print("Local")
                    self.data = .success(value)
                } else {
                    self.data = .failure(NetworkError.loadingError)
                }
            } else {
                print("Remote")
                /// Load from network
                task?.resume()

            }
        } else {
            task?.resume()
        }
    }
    
    func cancel() {
        if task != nil {
            task?.cancel()
        }
    }
}

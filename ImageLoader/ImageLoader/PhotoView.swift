//
//  PhotoView.swift
//  ImageLoader
//
//  Created by 1293 on 2020/5/14.
//  Copyright © 2020 maja. All rights reserved.
//

import SwiftUI

struct PhotoSizeKey:EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var photoSize: CGSize {
        get {
            self[PhotoSizeKey.self]
        }
        set {
            self[PhotoSizeKey.self] = newValue
        }
    }
}

extension View {
    func photoSize(_ size: CGSize) -> some View {
        /// Change enviroment
      environment(\.photoSize, size)
    }
}

struct PhotoView: View {
    let defaultImage = UIImage(named: "Placeholder")
    @Environment(\.photoSize) var size
    @ObservedObject var image: Remote<UIImage>
    
    init(url: URL) {
        image = Remote(url: url, transform: {
            print("url: \(url)")
            return UIImage(data: $0)
            
        })
    }
    
    var body: some View {
        Group {
            Image(uiImage: image.value ?? defaultImage!)
                .resizable()
                .aspectRatio(size, contentMode: .fit)
                .onAppear(perform: image.load)
        }
    }
}


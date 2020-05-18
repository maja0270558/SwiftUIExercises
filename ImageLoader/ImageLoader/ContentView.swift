//
//  ContentView.swift
//  ImageLoader
//
//  Created by 1293 on 2020/5/14.
//  Copyright © 2020 maja. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isAnimation: Bool = true
    @ObservedObject var remote: Remote<[ImageInfo]> = Remote(
        url: URL(string: "https://picsum.photos/v2/list")!) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
            return try? decoder.decode([ImageInfo].self, from: $0)
    }
    
    var body: some View {
        NavigationView {
            if remote.value == nil {
                ActiveIndicator(isAnimating: $isAnimation, style: .medium)
                .onAppear {
                    self.remote.load()
                }
            } else {
                List {
                    ForEach(remote.value!) { photo in
                        NavigationLink(destination: PhotoView(url: photo.downloadUrl)) {
                           
                            VStack {
                                HStack {
                                    PhotoView(url: photo.downloadUrl).frame(width: 100, height: 100, alignment: .leading)
                                    Text("\(photo.author)")
                                }.photoSize(CGSize(width: 100, height: 200))
                                
                                HStack {
                                    PhotoView(url: photo.downloadUrl).frame(width: 100, height: 100, alignment: .leading)
                                    Text("\(photo.author) 🤷🏻‍♂️")
                                }
                            }.photoSize(CGSize(width: 1, height: 1))
                            
                            
                            
                        }.onAppear {
                        }
                    }
                }
                
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ActiveIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    typealias  UIViewType = UIActivityIndicatorView

    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
                isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

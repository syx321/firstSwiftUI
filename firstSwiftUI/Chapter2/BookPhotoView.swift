//
//  BookPhotoView.swift
//  firstSwiftUI
//
//  Created by 苏易肖 on 2022/7/20.
//

import SwiftUI

struct BookPhotoView: View {
    let url: String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "photo")
                    .overlay {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.gray.opacity(0.4))
                    }
            }
            .aspectRatio(contentMode: .fit)
        }
    }
}

//
//  BookRow.swift
//  firstSwiftUI
//
//  Created by 苏易肖 on 2022/7/20.
//

import SwiftUI
import Foundation

struct BookRow: View {
    let book: Book
    @State var isLoading = true
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: book.download_url)) { image in
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
            .frame(width: 112, height: 112, alignment: .center)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("id:")
                    Text(book.id!)
                }
                HStack {
                    Text("author:")
                    Text(book.author!)
                }
            }
        }
    }
}

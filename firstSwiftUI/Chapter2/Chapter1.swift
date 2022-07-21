//
//  ContentView.swift
//  firstSwiftUI
//
//  Created by 苏易肖 on 2022/7/19.
//

import SwiftUI

//struct ContentView: View {
//    @State private var counter = 0
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8.0) {
//            Button(action: {counter += 1}, label: {
//                Text("Tapped")
//                    .padding()
//                    .background(Color(.tertiarySystemFill))
//                    .cornerRadius(5)
//            })
//            LabelView(num: $counter)
//
//        }
//        .printName("ContentView")
//        .padding(.all, 20)
//        .frame(width: 200, height: 350, alignment: .leading)
//        .background(Color.gray)
//        .cornerRadius(10)
//        .shadow(radius: 20)
//    }
//}
//
//struct LabelView: View {
//    @Binding var num: Int
//    var body: some View {
//        VStack {
//            Text("You've tapped \(num) times")
//        }
//        .printName("labelView")
//    }
//}
//
//extension View {
//    func debug() -> Self {
//        print(Mirror(reflecting: self).subjectType)
//        return self
//    }
//
//    func printName(_ content: String) -> Self {
//        print(content)
//        return self
//    }
//}

struct ContentView: View {
    @State var width: CGFloat = 10.0
    @State var height: CGFloat = 10.0
    @State var rotate: Double = 0.0
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: width, height: height, alignment: .center)
                .rotationEffect(Angle(degrees:Double(rotate) * 180))
                .foregroundColor(.brown)
                .padding()
                .shadow(radius: 20)
            
            HStack {
                Text("Width:")
                Slider(value: $width, in: (0...UIScreen.main.bounds.width))
            }
            HStack {
                Text("Height:")
                Slider(value: $height, in: (0...UIScreen.main.bounds.height - 300))
            }
            HStack {
                Text("Rotate:")
                Slider(value: $rotate, in: (0...1))
            }
        }
        .padding(.all, 15)
        .background(.gray)
        .shadow(radius: 10)
    }
}

struct Chapter1: View {
    let items = APIRequest<[Book]>(url: "https://picsum.photos/v2/list", transform: { try? JSONDecoder().decode([Book].self, from: $0)
    })
    @State var isLoading = true
    @State var books: [Book] = []
    
    var body: some View {
        VStack {
            NavigationView {
                List(books) { book in
                    NavigationLink {
                        BookPhotoView(url: book.download_url)
                    } label: {
                        BookRow(book: book)
                    }

                }
                .task {
                    await fetchBooks()
                }
                .overlay {
                    if isLoading {
                        ProgressView("loading")
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Books")
            }
            
        }
    }
    
    private func fetchBooks() async {
        let _ = await items.download()
        if let books = try? items.result?.get() {
            self.books = books
            self.isLoading = false
        }
    }
}

struct ContentViewPreview: PreviewProvider {
    static var previews: some View {
        ContentView()
        Chapter1()
    }
}

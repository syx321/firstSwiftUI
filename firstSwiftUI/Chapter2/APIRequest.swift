//
//  APIRequest.swift
//  firstSwiftUI
//
//  Created by 苏易肖 on 2022/7/20.
//

import Foundation

class LoadingError: Error{}

final class APIRequest<T>: ObservableObject {
    @Published var result: Result<T?, Error>? = nil
    let url: String
    let transform: (Data) -> T?
    
    init(url: String, transform: @escaping (Data) -> T?) {
        self.url = url
        self.transform = transform
    }
    
    func download() async {
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        do {
            let (data, _) = try await urlSession.data(for: request)
            if let v = transform(data) {
                result = .success(v)
            } else {
                result = .failure(LoadingError())
            }
        } catch {}
    }
}

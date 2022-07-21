//
//  Book.swift
//  firstSwiftUI
//
//  Created by 苏易肖 on 2022/7/20.
//

import Foundation

struct Book: Codable {
    let id: String?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let download_url: String
}

extension Book: Identifiable {}

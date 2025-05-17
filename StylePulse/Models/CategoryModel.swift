//
//  CategoryModel.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-20.
//

import Foundation


// MARK: - Welcome
struct CategoryModel: Codable {
    let status: Bool
    let data: [Category]?
}

// MARK: - Datum
struct Category: Codable {
    let id, code, name: String
    let level: Int
    let description, thumbnailImage: String
    let products: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case code, name, level, description, thumbnailImage, products
    }
}

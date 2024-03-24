//
//  ProductModel.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-24.
//

import Foundation

// MARK: - Welcome
struct ProductModel: Codable {
    let status: Bool
    let data: [Product]?
}

// MARK: - Datum
struct Product: Codable {
    let id, code, name, description: String?
    let isNewArrival, isMoreToLove: Int
    let rating: Double?
    let specialNote: String
    let category: String?
    let defaultPrice: Int
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case code, name, description, isNewArrival, isMoreToLove, rating, specialNote, category, defaultPrice, image
    }
}


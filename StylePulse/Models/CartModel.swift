//
//  CartModel.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-24.
//

import Foundation

// MARK: - Welcome
struct CartModel: Codable {
    let status: Bool
    let data: CartData?
}

// MARK: - DataClass
struct CartData: Codable {
    let id, deviceID: String
    let products: [CartProduct]?
    let v, cartSubTotal, taxTotal, itemsCount: Int
    let discountTotal, cartTotal: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case deviceID = "deviceId"
        case products
        case v = "__v"
        case cartSubTotal, taxTotal, itemsCount, discountTotal, cartTotal
    }
}

// MARK: - Product
struct CartProduct: Codable {
    let productID: ProductID
    let varient: Varient
    let quantity: Int
    let displayName, id: String

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case varient, quantity, displayName
        case id = "_id"
    }
}

// MARK: - ProductID
struct ProductID: Codable {
    let id, code, name, description: String
    let isNewArrival, isMoreToLove: Int
    let rating: Double
    let defaultPrice: Int
    let specialNote, image: String
    let isTaxEnabled, discount: Int
    let category: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case code, name, description, isNewArrival, isMoreToLove, rating, defaultPrice, specialNote, image, isTaxEnabled, discount, category
    }
}

// MARK: - Varient
struct Varient: Codable {
    let size, color: String
}

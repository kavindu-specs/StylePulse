//
//  BannerModel.swift
//  StylePulse
//
//  Created by Kavindu Prabodya on 2024-03-20.
//

import Foundation

// MARK: - Welcome
struct BannerModel: Codable {
    let status: Bool
    let data: [Banner]?
}

// MARK: - Datum
struct Banner: Codable {
    let id, name, description, type: String
    let image: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, description, type, image
    }
}


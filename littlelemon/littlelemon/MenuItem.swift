//
//  MenuItem.swift
//  littlelemon
//
//  Created by Tobias Schulz on 12.09.25.
//

import Foundation

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String
    let itemDescription: String
    let category: String

    enum CodingKeys: String, CodingKey {
        case title
        case image
        case price
        case itemDescription = "description"
        case category
    }
}

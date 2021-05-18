//
//  Model.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 18.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import Foundation


struct ListResponse: Codable {
    let metadata: String?
    let data: [DayModel]?
    let error: String?
}
struct DayModel : Codable {
    let date: String?
    let indexId: String?
    let indexDisplayName: String?
    let types: Types?
    struct Types: Codable {
        let grass: Allergen?
        let tree: Allergen?
        let weed: Allergen?
    }
    enum CodingKeys: String, CodingKey {
        case date
        case indexId = "indexId"
        case indexDisplayName = "indexDisplayName"
        case types
    }
}
struct Allergen: Codable {
    let displayName: String?
    let inSeason: Bool?
    let dataAvailable: Bool?
    let index: Index?
    struct Index: Codable {
        let value: Int?
        let category: String?
        let color: String?
    }
}

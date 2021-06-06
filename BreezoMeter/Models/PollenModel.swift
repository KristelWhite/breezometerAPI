//
//  Model.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 18.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//

import Foundation


//struct PollenResponse: Codable {
//    let metadata: Bool?
//    let data: [DayModel]?
//    let error: Bool?
//}
//struct DayModel : Codable {
//    let date: String?
//    let indexId: String?
//    let indexDisplayName: String?
//    let types: Types?
//    struct Types: Codable {
//        let grass: Allergen?
//        let tree: Allergen?
//        let weed: Allergen?
//    }
//    enum CodingKeys: String, CodingKey {
//        case date
//        case indexId = "indexId"
//        case indexDisplayName = "indexDisplayName"
//        case types
//    }
//}
//struct Allergen: Codable {
//    let displayName: String?
//    let inSeason: Bool?
//    let dataAvailable: Bool?
//    let index: Index?
//    struct Index: Codable {
//        let value: Int?
//        let category: String?
//        let color: String?
//    }
//}




// MARK: - PollenResponse
struct PollenResponse: Codable {
    let metadata: JSONNull?
    let data: [Datum]?
    let error: JSONNull?
}

// MARK: - Datum
struct Datum: Codable {
    let date, indexID, indexDisplayName: String?
    let types: Types?
    let plants: Plants?

    enum CodingKeys: String, CodingKey {
        case date
        case indexID = "indexId"
        case indexDisplayName = "indexDisplayName"
        case types, plants
    }
}

// MARK: - Plants
struct Plants: Codable {
    let graminales, hazel, oak, alder: Alder?
    let pine, cottonwood, ragweed, birch: Alder?
    let olive, ash: Alder?
}

// MARK: - Alder
struct Alder: Codable {
    let displayName: String?
    let inSeason, dataAvailable: Bool?
    let index: Index?

    enum CodingKeys: String, CodingKey {
        case displayName = "displayName"
        case inSeason = "inSeason"
        case dataAvailable = "dataAvailable"
        case index
    }
}

// MARK: - Index
struct Index: Codable {
    let value: Int?
    let category: String?
    let color: String?
}


// MARK: - Types
struct Types: Codable {
    let grass, tree, weed: Alder?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}




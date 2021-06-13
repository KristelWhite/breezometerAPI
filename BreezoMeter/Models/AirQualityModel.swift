//
//  AirQualityModel.swift
//  BreezoMeter
//
//  Created by Кристина Пастухова on 31.05.2021.
//  Copyright © 2021 Кристина Пастухова. All rights reserved.
//


import Foundation

// MARK: - AirQuality
struct AirQualityResponse: Codable {
    let metadata: Bool?
    let data: DataClass?
    let error: DataError?
}
// MARK: - Error
struct DataError: Codable {
    let code, title, detail: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let datetime: String?
    let dataAvailable: Bool?
    let indexes: Indexes?
    let pollutants: Pollutants?
    let healthRecommendations: HealthRecommendations?

    enum CodingKeys: String, CodingKey {
        case datetime
        case dataAvailable = "dataAvailable"
        case indexes, pollutants
        case healthRecommendations = "healthRecommendations"
    }
}

// MARK: - HealthRecommendations
struct HealthRecommendations: Codable {
    let generalPopulation, elderly, lungDiseases, heartDiseases: String?
    let active, pregnantWomen, children: String?

    enum CodingKeys: String, CodingKey {
        case generalPopulation = "generalPopulation"
        case elderly
        case lungDiseases = "lungDiseases"
        case heartDiseases = "heartDiseases"
        case active
        case pregnantWomen = "pregnantWomen"
        case children
    }
}

// MARK: - Indexes
struct Indexes: Codable {
    let baqi, fraAtmo: Baqi?

    enum CodingKeys: String, CodingKey {
        case baqi
        case fraAtmo = "fraAtmo"
    }
}

// MARK: - Baqi
struct Baqi: Codable {
    let displayName: String?
    let aqi: Int?
    let aqiDisplay: String?
    let color, category: String?
    let dominantPollutant: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "displayName"
        case aqi
        case aqiDisplay = "aqiDisplay"
        case color, category
        case dominantPollutant = "dominantPollutant"
    }
}

// MARK: - Pollutants
struct Pollutants: Codable {
    let co, no2, o3, pm10: Co?
    let pm25, so2: Co?
}

// MARK: - Co
struct Co: Codable {
    let displayName, fullName: String?
    let aqiInformation: AqiInformation?
    let concentration: Concentration?
    let sourcesAndEffects: SourcesAndEffects?

    enum CodingKeys: String, CodingKey {
        case displayName = "displayName"
        case fullName = "fullName"
        case aqiInformation = "aqiInformation"
        case concentration
        case sourcesAndEffects = "sourcesAndEffects"
    }
}

// MARK: - AqiInformation
struct AqiInformation: Codable {
    let baqi: Baqi?
}

// MARK: - Concentration
struct Concentration: Codable {
    let value: Double?
    let units: String?
}

// MARK: - SourcesAndEffects
struct SourcesAndEffects: Codable {
    let sources, effects: String?
}




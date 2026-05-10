//
//  HourlyPredictionData.swift
//  Nimbus
//
//  Created by Nick Konstantinou on 10/5/26.
//

struct HourlyPredictionData: Codable {
    let temperaturePerHour: [Double]
    let timeReference: [String]
    let weatherCode: [Int]
    
    enum CodingKeys: String, CodingKey {
        case temperaturePerHour = "temperature_2m"
        case timeReference = "time"
        case weatherCode = "weather_code"
    }
}

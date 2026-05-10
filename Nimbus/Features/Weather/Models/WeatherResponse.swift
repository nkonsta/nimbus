//
//  WeatherResponse.swift
//  Nimbus
//
//  Created by Nick Konstantinou on 10/5/26.
//


struct WeatherResponse: Codable {
    let current: CurrentWeatherData
    let hourlyPrediction: HourlyPredictionData
    
    enum CodingKeys: String, CodingKey {
        case current = "current"
        case hourlyPrediction = "hourly"
    }
}

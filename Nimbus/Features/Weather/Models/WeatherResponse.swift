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

struct CurrentWeatherData: Codable {
    let temperature: Double
    let isDay: Int
    let time: String
    let weatherCode: Int
    
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temperature_2m"
        case isDay = "is_day"
        case time = "time"
        case weatherCode = "weather_code"
    }
}

struct HourlyPredictionData: Codable {
    let temperaturePerHour: [Double]
    let timeReference: [String]
    
    enum CodingKeys: String, CodingKey {
        case temperaturePerHour = "temperature_2m"
        case timeReference = "time"
    }
}

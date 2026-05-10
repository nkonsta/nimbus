//
//  CurrentWeatherData.swift
//  Nimbus
//
//  Created by Nick Konstantinou on 10/5/26.
//

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

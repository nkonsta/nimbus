//
//  CurrentWeatherViewModel.swift
//  Nimbus
//
//  Created by Nick Konstantinou on 10/5/26.
//

import Foundation

struct CurrentWeatherViewModel {
    var temperatureText: String = ""
    var updatedAt: String = ""
    var weatherIcon: String = ""
    
    init(weather: CurrentWeatherData) {
        
            temperatureText = "\(weather.temperature)°C"
            weatherIcon = getWeatherIconName(for: weather.weatherCode, isDay: weather.isDay == 1)
            guard let responseDate = formatDate(dateString: weather.time) else { return }
            updatedAt = responseDate
    }
    
    private func formatDate(dateString: String) -> String? {
        let inputFormatter = DateFormatter()

        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()

            outputFormatter.dateFormat = "dd/MM/yyyy HH:mm"

            let formattedString = outputFormatter.string(from: date)

            return formattedString

        } else {
            return nil
        }
    }

    private func getWeatherIconName(for code: Int, isDay: Bool = true) -> String {
        switch code {
        case 0:
            return isDay ? "sun.max.fill" : "moon.stars.fill"
            
        case 1, 2:
            return isDay ? "cloud.sun.fill" : "cloud.moon.fill"
            
        case 3:
            return "cloud.fill"
            
        case 45, 48:
            return "cloud.fog.fill"
            
        case 51, 53, 55:
            return "cloud.drizzle.fill"
            
        case 56, 57:
            return "cloud.sleet.fill"
            
        case 61, 63, 65:
            return "cloud.rain.fill"
            
        case 66, 67:
            return "cloud.sleet.fill"
            
        case 71, 73, 75:
            return "cloud.snow.fill"
            
        case 77:
            return "snowflake"
            
        case 80, 81, 82:
            return "cloud.heavyrain.fill"
            
        case 85, 86:
            return "cloud.snow.fill"
            
        case 95:
            return "cloud.bolt.rain.fill"
            
        case 96, 99:
            return "cloud.bolt.rain.fill"
            
        default:
            return "questionmark.circle"
        }
    }
    
    
}

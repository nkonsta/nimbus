//
//  HourlyWeatherViewModel.swift
//  Nimbus
//
//  Created by Nick Konstantinou on 10/5/26.
//

import Foundation

struct HourlyWeatherViewModel {
    var hourlyWeather: [HourlyDataParsed] = []
    
    init(data: HourlyPredictionData, currentTime: String) {
        hourlyWeather = parsedHourlyData(data: data, currentTime:  currentTime)
    }
}

private func parsedHourlyData(data: HourlyPredictionData, currentTime: String) -> [HourlyDataParsed] {

        var result: [HourlyDataParsed] = []

        let count = min(
            data.temperaturePerHour.count,
            data.timeReference.count,
            data.weatherCode.count
        )

        for index in 0..<count {
            let parsed = HourlyDataParsed(
                weatherImage: getWeatherIconName(for: data.weatherCode[index]),
                temperature: "\(data.temperaturePerHour[index])°C",
                time: formatDate(dateString: data.timeReference[index], inputFormat: "yyyy-MM-dd'T'HH:mm", outputFormat: "HH:mm") ?? "-"
            )
            result.append(parsed)

        }

        return result

}

private func formatDate(dateString: String, inputFormat: String, outputFormat: String) -> String? {
    let inputFormatter = DateFormatter()

    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"

    if let date = inputFormatter.date(from: dateString) {

        let outputFormatter = DateFormatter()

        outputFormatter.dateFormat = "HH:mm"

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

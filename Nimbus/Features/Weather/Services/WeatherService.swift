//
//  WeatherService.swift
//  Nimbus
//
//  Created by Nick Konstantinou on 10/5/26.
//

import Foundation

class WeatherService {
    
    
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse {
        
        let meteoUrl = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m,weather_code&current=temperature_2m,is_day,weather_code&timezone=auto&forecast_days=1")!
        
        let (data, response) = try await URLSession.shared.data(from: meteoUrl)

                
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)

        return decodedData
        
    }
}

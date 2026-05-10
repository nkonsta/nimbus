//
//  WeatherViewModel.swift
//  Nimbus
//
//  Created by Nick Konstantinou on 10/5/26.
//

import Foundation
internal import Combine

@MainActor
final class WeatherViewModel: ObservableObject {

    @Published var temperatureText: String = ""
    @Published var updatedAt: String = ""
    @Published var isLoading = false
    @Published var weatherCode: Int = -1
    @Published var errorMessage: String?
    @Published var isInitialized: Bool = false

    private let service = WeatherService()

    func loadWeather() async {

        isLoading = true

        errorMessage = nil

        do {

            let (lat, long) = generateRandomLatLong()
            let response: WeatherResponse = try await service.fetchWeather(latitude: lat, longitude: long)
            weatherCode = response.current.weatherCode
            temperatureText = "\(response.current.temperature)°C"
            guard let responseDate = formatDate(dateString: response.current.time) else { return }
            updatedAt = responseDate
            isInitialized = true

        } catch {
            errorMessage = "Could not load weather"
        }
        isLoading = false
    }
}

private func generateRandomLatLong() -> (lat: Double, long: Double) {
    
    let lat = Double.random(in: -90...90)
    let long = Double.random(in: -180...180)
    
    return (lat, long)
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

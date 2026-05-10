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
    
    @Published var currentViewModel: CurrentWeatherViewModel?
    @Published var hourlyViewModel: HourlyWeatherViewModel?

    //Current weather view model values
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isInitialized: Bool = false
    
    //Hourly Forcast Values
    
    

    private let service = WeatherService()

    func loadWeather() async {

        isLoading = true
        errorMessage = nil

        do {

            let (lat, long) = generateRandomLatLong()
            let response: WeatherResponse = try await service.fetchWeather(latitude: lat, longitude: long)
            currentViewModel = CurrentWeatherViewModel(weather: response.current)
            hourlyViewModel = HourlyWeatherViewModel(data: response.hourlyPrediction, currentTime: response.current.time)
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

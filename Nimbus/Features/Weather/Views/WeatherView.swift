//
//  WeatherView.swift
//  Nimbus
//
//  Created by Nick Konstantinou on 10/5/26.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    var body: some View {
        VStack {
            Button("Fetch Weather") {
                Task {
                    await weatherViewModel.loadWeather()
                }
            }.buttonStyle(.borderedProminent)
            Spacer()
            VStack {
                if weatherViewModel.isLoading {
                    ProgressView()
                } else if let error = weatherViewModel.errorMessage {
                    Text(error)
                } else {
                    //Current weather card
                    if (weatherViewModel.isInitialized) {
                        VStack {
                            Text("Current Weather").font(.headline)
                            Text(weatherViewModel.weatherCode.description)
                            Text(weatherViewModel.temperatureText).bold()
                            Text("Updated at: \(weatherViewModel.updatedAt)").italic().font(.callout)
                        }
                        //Hourly forcast
                        VStack {
                            
                        }
                        
                    }
                }

            }
        }
    }
}

#Preview {
    WeatherView()
}

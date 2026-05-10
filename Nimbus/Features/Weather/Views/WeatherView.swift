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
            Button("Get random weather data") {
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
                        Text("Current Weather").font(.headline)
                        VStack {
                            if let current = weatherViewModel.currentViewModel {
                                Image(systemName: current.weatherIcon).font(.system(size: 40))
                                Text(current.temperatureText).bold()
                                Text(current.updatedAt).italic().font(.callout)
                            }
                        }
                        .background(Color.red.opacity(0.3))
                        .cornerRadius(10)
                        Spacer()
                        //Hourly forcast
                        Text("Hourly forecast").font(.headline)
                        ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(weatherViewModel.hourlyViewModel?.hourlyWeather ?? [], id: \.time) { item in
                                            VStack {
                                                Image(systemName: item.weatherImage).font(.system(size: 40))
                                                Text(item.temperature.description)
                                                Text(item.time)
                                            }.padding()
                                            .frame(width: 100, height: 100)
                                            .background(Color.red.opacity(0.3))
                                            .cornerRadius(10)
                                        }
                                    }
                                    .padding()
                        }
                        Spacer()
                        
                    } else {
                        VStack {
                            Image(systemName: "exclamationmark.triangle.fill").font(.system(size: 40))
                        }
                        Text("No data to display")
                    }
                }

            }
            Spacer()
        }
    }
}

#Preview {
    WeatherView()
}

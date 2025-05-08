//
//  ContentView.swift
//  Basic Weather
//
//  Created by Ahmet Bostancıoğlu on 5.05.2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    @State private var cityInput = ""
    
    var body: some View {
        VStack {
            
            Spacer()
            VStack{
                if viewModel.cityName != "" {
                    Text("\(viewModel.cityName), \(viewModel.country)")
                        .font(.title2)
                }
                
                if let url = URL(string: viewModel.iconURL) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .frame(width: 70, height: 70)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Text("\(viewModel.temperature)")
                    .font(.title)
                    .bold()

                
                Text("\(viewModel.conditionText)")
                    .font(.headline)
                
                
            }
            
            Spacer()
            
            TextField("City Name", text: $cityInput)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    viewModel.fetchWeather(for: cityInput)
                }
            
            Button("Get Weather") {
                viewModel.fetchWeather(for: cityInput)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

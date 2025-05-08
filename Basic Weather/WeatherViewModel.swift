//
//  Weather.swift
//  Basic Weather
//
//  Created by Ahmet Bostancıoğlu on 5.05.2025.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    struct WeatherResponse: Codable {
        let location: Location
        let current: Current
    }
    

    struct Location: Codable {
        let name: String
        let country: String
    }

    struct Current: Codable {
        let temp_c: Double
        let condition: Condition
    }

    struct Condition: Codable {
        let text: String
        let icon: String
    }
    
    @Published var cityName = String()
    @Published var country = String()
    @Published var temperature = String()
    @Published var conditionText = String()
    @Published var iconURL = String()
    
    func fetchWeather(for city: String) {
        let apiKey = "e32e5d6159ba461cb41164324250505"
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)&aqi=no"
        
        guard let url = URL(string: urlString) else {
            print("URL not found.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Data not found.")
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self?.cityName = weatherResponse.location.name
                    self?.country = weatherResponse.location.country
                    self?.temperature = "\(weatherResponse.current.temp_c)°C"
                    self?.conditionText = weatherResponse.current.condition.text
                    self?.iconURL = "https:" + weatherResponse.current.condition.icon
                }
                
                
            } catch {
                print("JSON decoding error: \(error)")
            }
        }
        task.resume()
    }
    
}

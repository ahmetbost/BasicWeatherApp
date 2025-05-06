//
//  Weather.swift
//  Basic Weather
//
//  Created by Ahmet Bostancıoğlu on 5.05.2025.
//

import Foundation

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

func fetchWeather(for city: String) {
    let apiKey = "e32e5d6159ba461cb41164324250505"
    let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)&aqi=no"
    
    guard let url = URL(string: urlString) else {
        print("URL not found.")
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
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
            print("Şehir: \(weatherResponse.location.name)")
            print("Ülke: \(weatherResponse.location.country)")
            print("Sıcaklık: \(weatherResponse.current.temp_c)°C")
            print("Durum: \(weatherResponse.current.condition.text)")
            print("Ikon: \(weatherResponse.current.condition.icon)")
        } catch {
            print("JSON decoding error: \(error)")
        }
    }
    task.resume()
}

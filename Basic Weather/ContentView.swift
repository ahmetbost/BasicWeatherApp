//
//  ContentView.swift
//  Basic Weather
//
//  Created by Ahmet Bostancıoğlu on 5.05.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var city = ""
    
    var body: some View {
        VStack {
            
            TextField("City Name", text: $city)
            
            Button("Get Weather") {
                fetchWeather(for: city)
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

//
//  SwiftyWeatherApp.swift
//  SwiftyWeather
//
//  Created by Daniel Harris on 29/03/2025.
//

import SwiftUI
import SwiftData

@main
struct SwiftyWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .modelContainer(for: Preference.self)
        }
    }
    
    //Prints out the application support directory in order to find the data in the simulator to make sure everything saves
    
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
    
}

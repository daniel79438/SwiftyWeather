//
//  WeatherViewModel.swift
//  SwiftyWeather
//
//  Created by Daniel Harris on 31/03/2025.
//

import Foundation

@Observable // Necessary for JSON parsing
class WeatherViewModel {
    
    struct Returned: Codable {
        var current : Current // Key value from JSON
        var daily : Daily
    }
    
    struct Current: Codable { // Data structure that we want to use for parsing
        var temperature_2m : Double
        var apparent_temperature : Double
        var wind_speed_10m : Double
        var weather_code : Int
    }
    
    struct Daily: Codable {
        var time: [String] = []
        var weather_code: [Int] = []
        var temperature_2m_max: [Double] = []
        var temperature_2m_min: [Double] = []
    }
    
    var temperature = 0.0 // <- temperature_2m
    var feelsLike = 0.0 // <- apparent_temperature
    var windspeed = 0.0 // <- wind_speed_10m
    var weatherCode = 0 // <- weather_code
    var date: [String] = []
    var dailyWeatherCode: [Int] = []
    var dailyHighTemp: [Double] = []
    var dailyLowTemp: [Double] = []
    
    var urlString = "https://api.open-meteo.com/v1/forecast?latitude=42.33467401570891&longitude=-71.17007347605109&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m&hourly=uv_index&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&timezone=auto"
    
    func getData() async {
    print("🕸️ We are accessing URL: \(urlString)")
        // The API call can't be made with a string, it has to be converted to a URL data type:
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        // Make a call to URL session
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //Try to decode JSON into our own data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else { //Returned.self is the first data structure that is getting data back
                print("😡 JSON ERROR: Could not decode returned JSON")
                return
            }
            temperature = returned.current.temperature_2m
            feelsLike = returned.current.apparent_temperature
            windspeed = returned.current.wind_speed_10m
            weatherCode = returned.current.weather_code
            date = returned.daily.time
            dailyWeatherCode = returned.daily.weather_code
            dailyHighTemp = returned.daily.temperature_2m_max
            dailyLowTemp = returned.daily.temperature_2m_min
            print(date)
            print(dailyWeatherCode)
            print(dailyHighTemp)
            print(dailyLowTemp)
          
        } catch {
            print("😡 ERROR: Could not data from \(urlString)")

            
        }
        
    }
    
}

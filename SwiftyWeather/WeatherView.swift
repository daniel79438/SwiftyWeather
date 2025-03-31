//
//  WeatherView.swift
//  SwiftyWeather
//
//  Created by Daniel Harris on 29/03/2025.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        
        NavigationStack{
            ZStack {
                Color(.cyan.opacity(0.75))
                    .ignoresSafeArea() // full screen
                VStack (spacing: 0){
                    
                    Image(systemName:"cloud.sun.rain.fill")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal) //padding to the sides only
                        .symbolRenderingMode(.multicolor) //If the image has 2 colors then this utilises them
                    
                    // Text Views
                    Text("Wild Weather")
                        .font(.largeTitle)
                    
                    Text("42°F")
                        .font(.system(size: 150, weight: .thin))
                    
                    Text("Wind 10mph - Feels Like 36°F")
                        .font(.title2)
                        .padding(.bottom) //padding only to the bottom of this text View
                }
                .foregroundStyle(.white)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            //TODO: Add gear click here
                        } label: {
                            Image(systemName: "gear")
                            
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


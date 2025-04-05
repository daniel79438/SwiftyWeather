//
//  Preference.swift
//  SwiftyWeather
//
//  Created by Daniel Harris on 05/04/2025.
//

import Foundation
import SwiftData

@MainActor
@Model
class Preference {
    var locationName = ""
    var latString = ""
    var longString = ""
    var selectedUnit = UnitSystem.imperial
    var degreeUnitShowing = true
    
    init(locationName: String = "", latString: String = "", longString: String = "", selectedUnit: UnitSystem = UnitSystem.imperial, degreeUnitShowing: Bool = true) {
        self.locationName = locationName
        self.latString = latString
        self.longString = longString
        self.selectedUnit = selectedUnit
        self.degreeUnitShowing = degreeUnitShowing
    }
}

extension Preference {
    //create a property named Preview for mock data, but instead setting it equal to a value, it is being computed inside. Interally it has a container and then it goes in the variable Preview.
    static var preview: ModelContainer {
        
        let container = try! ModelContainer(for: Preference.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        //Add mock data
        container.mainContext.insert(
            Preference(
                locationName: "Dublin, Ireland",
                latString: "53.33880",
                longString: "-6.2551",
                selectedUnit: .metric,
                degreeUnitShowing: true
            )
        )
        
        return container
        
    }
}

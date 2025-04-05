//
//  PreferenceView.swift
//  SwiftyWeather
//
//  Created by Daniel Harris on 04/04/2025.
//

import SwiftUI
import SwiftData

struct PreferenceView: View {
    @Query var preferences: [Preference]
    @State private var locationName = ""
    @State private var latString = ""
    @State private var longString = ""
    @State private var selectedUnit = UnitSystem.imperial
    @State private var degreeUnitShowing = true
    var degreeUnit: String {
        if degreeUnitShowing {
            return selectedUnit == .imperial ? "F" : "C"
        }
        return ""
    }
    
    //We always create an environment variable for model context
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss //Allows for exit of the view when needed
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                TextField("location", text: $locationName)
                    .textFieldStyle(.roundedBorder)
                    .font(.title)
                    .padding(.bottom)
                
                
                Group {
                    Text("Latitude:")
                        .bold()
                    
                    TextField("Lattitude", text: $latString)
                    
                    Text("Longitude:")
                        .bold()
                    TextField("Longitude", text: $longString)
                        .padding(.bottom)
                }
                .font(.title2)
                
                HStack{
                    Text("Units: ")
                        .bold()
                    
                    Spacer()
                    
                    Picker("", selection: $selectedUnit) {
                        ForEach(UnitSystem.allCases, id: \.self) { unit in
                            Text(unit.rawValue.capitalized)
                            
                        }
                    }
                    .padding(.bottom)
                }
                .font(.title2)
                
                Toggle("Show F/C after temp value:", isOn: $degreeUnitShowing)
                    .font(.title2)
                    .bold()
                
                HStack {
                    Spacer()
                    Text("42°\(degreeUnit)")
                        .font(.system(size: 150))
                        .fontWeight(.thin)
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        //We only want to save one element to the array, so delete all others before we save:
                        
                        if !preferences.isEmpty {
                            for preference in preferences {
                                modelContext.delete(preference)
                            }
                        }
                        let preference = Preference(
                            locationName: locationName,
                            latString: latString,
                            longString: longString,
                            selectedUnit: selectedUnit,
                            degreeUnitShowing: degreeUnitShowing
                        )
                        modelContext.insert(preference)
                        guard let _ = try? modelContext.save() else {
                            print("😡 ERROR: Save on PreferenceView failed")
                            return
                        }
                        dismiss()
                    }
                }
            }
        }
        .task{
            guard !preferences.isEmpty else { return } //If preferences is not empty the guard will return
            let preference = preferences.first! // force unwrapped because we won't get a nil error
            locationName = preference.locationName
            latString = preference.latString
            longString = preference.longString
            selectedUnit = UnitSystem.imperial
            degreeUnitShowing = true
        }
        
    }
}

#Preview {
    PreferenceView()
        .modelContainer(Preference.preview)
}

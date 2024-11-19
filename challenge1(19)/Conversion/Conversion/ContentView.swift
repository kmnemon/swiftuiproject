//
//  ContentView.swift
//  Conversion
//
//  Created by ke on 2024/9/9.
//

import SwiftUI

struct Temperature {
    static func toCelsius(_ temperature: String, _ value: Double) -> Double {
        switch temperature {
        case "fahrenheit":
            return (value - 32) * 5 / 9
        case "kelvin":
            return value - 273.15
        default:
            return value
        }
    }
    
    static func celsiusTo(_ celsius: Double, _ temperature: String) -> Double {
        switch temperature {
        case "fahrenheit":
            return celsius * 9 / 5 + 32
        case "kelvin":
            return celsius + 273.15
        default:
            return celsius
        }
    }
}

struct Length {
    static func toMeters(_ length: String, _ value: Double) -> Double {
        return 0.0
    }
    
    static func metersTo(_ meters: Double, _ length: String) -> Double {
        return 0.0
    }
}

struct ContentView: View {
    @State private var convertType: String = "Temperature"
    
    @State private var inputValue = 0.0
    var outputValue: Double {
        switch convertType {
        case "Temperature":
            return Temperature.celsiusTo(Temperature.toCelsius(inputUnit, inputValue), outputUnit)
        case "Length":
            return Length.metersTo(Length.toMeters(inputUnit, inputValue), outputUnit)
        default:
            return 0.0
        }
    }
    
    @State private var inputUnit: String = "celsius"
    @State private var outputUnit: String = "celsius"
    
    @State private var units: [String]?
    
    @FocusState private var amountIsFocused: Bool
    
    let convertTypes = ["Temperature", "Length", "Time", "Volume"]
    
    let temperatureUnit = ["celsius", "fahrenheit", "kelvin"]
    let lengthUnit = ["meters", "kilometers", "feet", "yard", "miles"]
    let timeUnit = ["seconds", "minutes", "hours", "days"]
    let volumeUnit = ["milliliters", "liters", "cups", "pints", "gallons"]
    
    var body: some View {
        
        NavigationStack {
            Form {
                Picker("Type", selection: $convertType) {
                    ForEach(convertTypes, id: \.self) {
                        Text($0)
                    }
                }
                .onChange(of: convertType) {
                    (units, inputUnit) = getUnits(convertType)
                    outputUnit = inputUnit
                }
                
                Section("Input") {
                    TextField("Input", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(units ?? temperatureUnit, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output") {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(units ?? temperatureUnit, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text(String(format: "%.2f", outputValue))
                }

            }
            .navigationTitle("Conversion")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    
    func getUnits(_ type: String) -> ([String], String) {
        switch convertType {
        case "Temperature":
            return (temperatureUnit, "celsius")
        case "Length":
            return (lengthUnit, "meters")
        case "Time":
            return (timeUnit, "seconds")
        case "Volume":
            return (volumeUnit, "milliliters")
        default:
            return (temperatureUnit, "celsius")
        }
    }
}



#Preview {
    ContentView()
}

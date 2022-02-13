//
//  ContentView.swift
//  CurrencyConverterUI
//
//  Created by Uladzimir Kulakou on 2/13/22.
//

import SwiftUI

struct ContentView: View {
    @State private var itemSelected = 0
    @State private var itemSelected2 = 1
    @State private var amount: String = ""
    @State private var amount2: String = ""
    private let currencies = ["USD", "EUR", "RUB","BLR"]
    private let flags = [ "🇺🇸", "🇪🇺",  "🇷🇺", "🇧🇾"]
    
    func convert(_ convert: String) -> String {
        var conversion: Double = 1.0
        let amount = Double(convert) ?? 0.0
        let selectedCurrency = currencies[itemSelected]
        let to = currencies[itemSelected2]
        
        let euroRates = ["USD": 0.9, "EUR": 1.0, "RUB": 10.0, "BLR": 3.0]
        let usdRates = ["USD": 1.0, "EUR": 1.1, "RUB": 11.1, "BLR": 2.5]
        let rubRates = ["USD": 0.11, "EUR": 9.09, "RUB": 1.0, "BLR": 0.3]
        let blrRates = ["USD": 2.6, "EUR": 1.99, "RUB": 3, "BLR": 1.0]
        
        
        switch (selectedCurrency) {
        case "USD" :
            conversion = amount * (usdRates[to] ?? 0.0)
        case "EUR" :
            conversion = amount * (euroRates[to] ?? 0.0)
        case "RUB" :
            conversion = amount * (rubRates[to] ?? 0.0)
        case "BLR" :
            conversion = amount * (blrRates[to] ?? 0.0)
            
        default:
            print("O-o-o-ps!")
        }
        
        
        
        
        return String(format: "%.2f", conversion)
    }
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert a currency")) {
                    TextField("\(convert(amount2)) ", text: $amount).keyboardType(.decimalPad)
                    
                    HStack {
                        Label("From", systemImage: "")
                        Picker(selection: $itemSelected,  label: Text(flags[itemSelected])) {
                            ForEach(0 ..< currencies.count) {index in
                                Text(self.currencies[index]).tag(index)
                                
                            }
                        }
                    }.padding()
                    
                    HStack{
                        Label("To", systemImage: "")
                        Picker(selection: $itemSelected2,  label: Text(flags[itemSelected2])) {
                            ForEach(0 ..< currencies.count) {index in
                                Text(self.currencies[index]).tag(index)
                                
                            }
                        }
                    }
                    
                    TextField("\(convert(amount)) ", text: $amount2).keyboardType(.decimalPad)
                    
                }
//                Section(header: Text("Conversion")) {
//                    Text("\(convert(amount)) \(currencies[itemSelected2])")
//                }
                
            }
        }.navigationTitle("Convertor")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

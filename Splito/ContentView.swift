//
//  ContentView.swift
//  Splito
//
//  Created by Martin on 2024/10/19.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount: Double = 0.0
    @State private var numberOfPeople: Int = 0
    @State private var tipPercentage: Double = 0.10
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages: [Double] = [0.0, 0.10, 0.15, 0.20, 0.25]
    
    var billTotal: Double {
        let tipAmount = billAmount * tipPercentage
        return billAmount + tipAmount
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipAmount = billAmount * tipSelection
        let billTotal = billAmount + tipAmount
        let amountPerPerson = billTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Bill amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "ZAR"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Done") {
                                        amountIsFocused = false
                                    }
                                }
                            }
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<11) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Tip Percentage") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    HStack {
                        Text("Tip amount:")
                        Spacer()
                        Text(billAmount * tipPercentage, format: .currency(code: Locale.current.currency?.identifier ?? "ZAR"))
                    }
                }
                
                Section {
                    HStack {
                        Text("Bill total:")
                        Spacer()
                        Text(billTotal, format: .currency(code: Locale.current.currency?.identifier ?? "ZAR"))
                    }
                    
                    HStack {
                        Text("Each person:")
                        Spacer()
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "ZAR"))
                    }
                }
            }
            .navigationTitle("Splito")
        }
    }
}

#Preview {
    ContentView()
}

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

    var actualNumberOfPeople: Int {
        numberOfPeople + 2
    }

    var tipAmount: Double {
        billAmount * tipPercentage
    }

    var billTotal: Double {
        billAmount + tipAmount
    }

    var totalPerPerson: Double {
        let peopleCount = Double(actualNumberOfPeople)
        if peopleCount <= 0 {
            return 0.0
        }
        return billTotal / peopleCount
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Enter Bill Amount")
                            .font(.headline)
                            .foregroundColor(.secondary)

                        HStack {
                            Image(systemName: "dollarsign.circle")
                                .foregroundColor(.green)

                            TextField("Amount", value: $billAmount, format: .currency(code: Locale.current.currency?.identifier ?? "ZAR"))
                                .keyboardType(.decimalPad)
                                .focused($amountIsFocused)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("How many people?")
                            .font(.headline)
                            .foregroundColor(.secondary)

                        Stepper("People: \(actualNumberOfPeople)", value: $numberOfPeople, in: 0...48)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tip Percentage")
                            .font(.headline)
                            .foregroundColor(.secondary)

                        Picker("Tip Percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal, -4)
                    }
                     .padding(.horizontal)

                    VStack(spacing: 15) {
                         Text("Calculation Summary")
                              .font(.title2)
                              .fontWeight(.semibold)
                              .foregroundColor(.primary)

                        HStack {
                            Text("Tip Amount:")
                            Spacer()
                            Text(tipAmount, format: .currency(code: Locale.current.currency?.identifier ?? "ZAR"))
                                .fontWeight(.medium)
                        }

                        HStack {
                            Text("Total Bill (including tip):")
                            Spacer()
                            Text(billTotal, format: .currency(code: Locale.current.currency?.identifier ?? "ZAR"))
                                .fontWeight(.medium)
                        }

                        Divider()

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Amount per person:")
                                .font(.title3)
                                .fontWeight(.medium)

                            Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "ZAR"))
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.green)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 8)
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(8)
                        }
                         .padding(.top, 10)

                    }
                    .padding()
                    .background(Color(.systemGray5).opacity(0.3))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    Image(systemName: "person.3.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.secondary)
                                    .padding(.top, 25)

                    Spacer()

                }
                .padding(.top)

            }
            .navigationTitle("Splito")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}


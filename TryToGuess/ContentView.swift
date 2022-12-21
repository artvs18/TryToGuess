//
//  ContentView.swift
//  TryToGuess
//
//  Created by Artemy Volkov on 18.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var targetValue = Int.random(in: 0...100)
    @State private var currentValue = Double.random(in: 0...100)
    @State private var isPresented = false
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Подвиньте слайдер как можно ближе к: \(targetValue)")
             
            HStack {
                Text("0")
                SliderView(
                    currentValue: $currentValue,
                    thumbColor: .red,
                    thumbOpacity: Double(computeScore()) / 100
                )
                Text("100")
            }
            
            Button("Проверь меня!") { isPresented.toggle() }
                .alert("Your score", isPresented: $isPresented, actions: {}) {
                    Text(computeScore().formatted())
                }
        
            Button("Начать заново") {
                withAnimation {
                    targetValue = .random(in: 0...100)
                    currentValue = .random(in: 0...100)
                }
            }
        }
        .padding()
    }
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return 100 - difference
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

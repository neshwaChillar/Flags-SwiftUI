//
//  ContentView.swift
//  Flags
//
//  Created by Neshwa on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showScore = false
    @State private var score = ""
    
    @State private var countries = [ "Armenia", "Brazil", "China", "Europe",
                      "Greece", "Guam", "India", "Indonesia",
                      "Italy", "Latvia", "Malta", "Pakistan",
                      "Palau", "Srilanka", "Sweden", "USA"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .resizable()
                                .renderingMode(.original)
                                .scaledToFit()
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Score")
                    .foregroundStyle(.white)
            }
        }
        .alert(score, isPresented: $showScore) {
            Button("Continue", action: askQuestions)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score = "Correct"
        } else {
            score = "Wrong"
        }
        showScore = true
    }
    
    func askQuestions() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}

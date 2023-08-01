//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Vladimir Dvornikov on 27/07/2023.
//

import SwiftUI

// custom modifier
struct LargeBlue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.semibold))
            .foregroundColor(.blue)
    }
}
// extension for modifier
extension View {
    func largeBlue() -> some View {
        modifier(LargeBlue())
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var gameOver = false
    @State private var scoreTitle = ""
    @State private var countries = allCountries.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var correctScore = 0
    @State private var wrongScore = 0
    @State private var questionCount = 0
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.gray, .black,], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                HStack {
                    Text("wrong: \(wrongScore)")
                    Spacer()
                    Text("correct: \(correctScore)")
                }
                .padding(30)
                .foregroundColor(.white)
                Spacer()
                
                VStack {
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.bold))
                    
                    Text(countries[correctAnswer])
                        .largeBlue()
                }
                .foregroundColor(.white)
                .padding(30)
                
                ForEach(0..<3) { number in
                    Button {
                    flagTapped(number)
                    } label: {
                        FlagImage(name: countries[number])
                    }
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue") {
                if questionCount < 8 {
                    askQuestion()
                } else {
                    gameOver = true
                }
            }
        } message: {
            Text("Your score is \(correctScore)")
        }
        .alert("Game over!", isPresented: $gameOver) {
            Button("Start new game") {
                newGame()
                askQuestion()
            }
        } message: {
            Text("\(correctScore) correct answers and \(wrongScore) wrong answers")
        }
    }
    
    func flagTapped(_ number: Int) {
        questionCount += 1

        if number == correctAnswer {
            scoreTitle = "Correct"
            correctScore += 1
        } else {
            let needsThe = ["US", "UK"]
            let theirAnswer = countries[number]
            
            if needsThe.contains(theirAnswer) {
                scoreTitle = "Wrong! That's the flag of the \(theirAnswer)."
            } else {
                scoreTitle = "Wrong! That's the flag of \(theirAnswer)."
                wrongScore += 1
            }
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func newGame() {
        correctScore = 0
        wrongScore = 0
        questionCount = 0
        countries = Self.allCountries
     askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

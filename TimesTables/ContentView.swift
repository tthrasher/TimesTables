//
//  ContentView.swift
//  TimesTables
//
//  Created by Terry Thrasher on 2021-04-29.
//
//  Consolidation project from 100 Days of SwiftUI
//  The goal is to build an "edutainment" app for kids to help them practice multiplication tables.
//  The criteria for this app are as follows:
//      1. The player needs to select which multiplication tables they want to practice.
//      2. The player should be able to select how many questions they want to be asked: 5, 10, 20, or "all".
//      3. The app should randomly generate as many questions as they ask for, within the difficulty range they asked for. For the "all" case the app should generate all possible combinations.
//
//  Suggestions for how to complete the app:
//      1. Start with a single view app template, then add some state to determine whether the game is active or prompting for settings.
//      2. Because the app has two different states it should use a Group as a top-level view.
//      3. Try and break up your layouts into new SwiftUI views, rather than putting everything in ContentView.
//      4. Show the player how many questions they got correct at the end of the game, then offer to let them play again.


import SwiftUI

struct TimesTableQuestion: View {
    
    var firstNumber: String
    var secondNumber: String
    
    var body: some View {
        Text("What is \(firstNumber) x \(secondNumber)?")
            .font(.largeTitle)
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var promptingForSettings = false
    @State private var selectedNumberOfQuestions = 0
    @State private var correctAnswers = 0
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    
    let numberOfQuestions = ["5", "10", "20", "All"]
    let questions = [String]()
    
    var body: some View {
        NavigationView {
            Group {
                VStack {
                    Text("Time for math!")
                    
                    Section(header: Text("How many questions do you want to try?")) {
                        Picker("Questions", selection: $selectedNumberOfQuestions) {
                            ForEach(0..<numberOfQuestions.count) {
                                Text("\(self.numberOfQuestions[$0])!")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Text("Score: \(correctAnswers)")
                }
                .navigationTitle("TimesTables")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

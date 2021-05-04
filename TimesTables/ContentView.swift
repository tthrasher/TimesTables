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

struct ContentView: View {
    @State private var promptingForSettings = true
    @State private var showingResultAlert = false
    @State private var scoreMessage = ""
    
    @State private var selectedNumberOfQuestions = 0
    @State private var selectedMultiplier = 0
    @State private var score = 0
    
    @State private var numberOfQuestions = ["5", "10", "20", "All"]
    @State private var questions = [String]()
    @State private var questionsToAskThisRound = 0
    @State private var currentlyShownQuestion = 0
    @State private var correctAnswers = [Int]()
    @State private var currentQuestion = ""
    @State private var currentAnswer = ""
    
    var body: some View {
        NavigationView {
            Group {
                if promptingForSettings {
                    VStack {
                        Text("Time for math!")
                        
                        Section(header: Text("How many questions do you want to try?")) {
                            Picker("Questions", selection: $selectedNumberOfQuestions) {
                                ForEach(0..<numberOfQuestions.count) {
                                    Text("\(self.numberOfQuestions[$0])")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                        }
                        
                        Section(header: Text("Which times tables do you want to do?")) {
                            Picker("Multiplier", selection: $selectedMultiplier) {
                                ForEach(0..<12) {
                                    Text("\($0 + 1)")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                        }
                        
                        Spacer()
                        
                        Button("Let's go!") {
                            askTimesTablesQuestions(numberOfQuestions: selectedNumberOfQuestions)
                            promptingForSettings = false
                        }
                        .frame(maxWidth: 200, maxHeight: 50)
                        .overlay(Rectangle().stroke(Color.black, lineWidth: 3))
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                        
                        
                        Text("Score: \(score)")
                    }
                }
                    
                else {
                    VStack {
                        Text("Here come the questions!")
                            .font(.largeTitle)
                            .padding(50)
                            
                        Text("\(currentQuestion)")
                            .font(.title2)
                            .padding(50)
                            
                        TextField("Your answer", text: $currentAnswer)
                            .keyboardType(.decimalPad)
                            .padding(20)
                        
                        Button("Check my answer") {
                            checkAnswerTapped()
                        }
                        .frame(maxWidth: 240, maxHeight: 50)
                        .overlay(Rectangle().stroke(Color.black, lineWidth: 3))
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
            
                        Text("Question \(currentlyShownQuestion + 1) of \(numberOfQuestions[selectedNumberOfQuestions])")
                    }
                    .alert(isPresented: $showingResultAlert) {
                        Alert(title: Text("Result"), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                            self.showingResultAlert = false
                        })
                    }
                }
            }
            .navigationTitle("TimesTables")
        }
    }
    
    func askTimesTablesQuestions(numberOfQuestions: Int) {
        switch numberOfQuestions {
        case 0:
            generateQuestions(number: 5)
            questionsToAskThisRound = 5
            
        case 1:
            generateQuestions(number: 10)
            questionsToAskThisRound = 10
            
        case 2:
            generateQuestions(number: 20)
            questionsToAskThisRound = 20
            
        default:
            generateQuestions(number: 30)
            questionsToAskThisRound = 30
        }
        
        currentQuestion = questions[currentlyShownQuestion]
    }
    
    func generateQuestions(number: Int) {
        var multiplicands = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]
        
        for i in 1...number {
            multiplicands.shuffle()
            let multiplicand = multiplicands[i]
            let correctAnswer = (selectedMultiplier + 1) * multiplicand
            correctAnswers.append(correctAnswer)
            let question = "What is \(selectedMultiplier + 1) times \(multiplicand)?"
            questions.append(question)
        }
    }
    
    func checkAnswerTapped() {
        let numberToBeChecked = Int(currentAnswer) ?? 0
        
        if numberToBeChecked == correctAnswers[currentlyShownQuestion] {
            scoreMessage = "Correct!"
            score += 1
        } else {
            scoreMessage = "Wrong. The correct answer is \(correctAnswers[currentlyShownQuestion])."
        }
        
        showingResultAlert = true
        currentlyShownQuestion += 1
        questionsToAskThisRound -= 1
        currentAnswer = ""
        
        if questionsToAskThisRound == 0 {
            promptingForSettings = true
            questions.removeAll()
            correctAnswers.removeAll()
            currentlyShownQuestion = 0
            questionsToAskThisRound = 0
            
            return
        }

        currentQuestion = questions[currentlyShownQuestion]
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

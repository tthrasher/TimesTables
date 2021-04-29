# TimesTables
Consolidation project (Day 35) from 100 Days of SwiftUI

Your goal is to build an “edutainment” app for kids to help them practice multiplication tables – “what is 7 x 8?” and so on. Edutainment apps are educational at their code, but ideally have enough playfulness about them to make kids want to play.

The criteria for this app are as follows:
  1. The player needs to select which multiplication tables they want to practice.
  2. The player should be able to select how many questions they want to be asked: 5, 10, 20, or "all".
  3. The app should randomly generate as many questions as they ask for, within the difficulty range they asked for. For the "all" case the app should generate all possible combinations.

Suggestions for how to complete the app:
  1. Start with a single view app template, then add some state to determine whether the game is active or prompting for settings.
  2. Because the app has two different states it should use a Group as a top-level view.
  3. Try and break up your layouts into new SwiftUI views, rather than putting everything in ContentView.
  4. Show the player how many questions they got correct at the end of the game, then offer to let them play again.

//
//  PlayingCardAppApp.swift
//  PlayingCardApp
//
//   Created by Kristina & Adi
//

import SwiftUI

@main
struct PlayingCardAppApp: App {
    @State var currentScreen = CurrentScreen.InitializationScreen
    @State var playerScore = 0
    @State var pcScore = 0
    
    enum CurrentScreen {
        case InitializationScreen
        case Playing
        case Score
    }
    var body: some Scene {
        WindowGroup {
            
            switch currentScreen {
            case .InitializationScreen:
                InitializationView(dispalyingCurApp: $currentScreen)
            case .Playing:
                PlayingView(dispalyingCurApp: $currentScreen, playerScore: $playerScore, pcScore: $pcScore)
                    .onAppear {
                    // Reset scores to zero when entering PlayingView
                    playerScore = 0
                    pcScore = 0
                }
            case .Score:
                ScoreView(dispalyingCurApp: $currentScreen, playerScore: $playerScore, pcScore: $pcScore)
                
            }
            
           
        }
    }
}

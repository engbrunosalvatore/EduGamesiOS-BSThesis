//
//  AppTesi1App.swift
//  AppTesi1
//
//  Created by Salvatore Bruno on 13/03/23.
//

import SwiftUI

class ScoreManagerDay: ObservableObject {
    @Published var score: Int
    @Published var lastDay: Int
    
    init() {
        self.score = UserDefaults.standard.integer(forKey: "score")
        self.lastDay = UserDefaults.standard.integer(forKey: "lastDay")
        
        // Reset score if lastDay is different from current day
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: currentDate)
        if components.day != lastDay {
            score = 0
            lastDay = components.day ?? 0
            UserDefaults.standard.set(lastDay, forKey: "lastDay")
            UserDefaults.standard.set(score, forKey: "score")
        }
    }
    
    func increaseScore(int: Int) {
        score += int
        UserDefaults.standard.set(score, forKey: "score")
    }
}

class ScoreManager: ObservableObject {
    @Published var score: Int
    
    init() {
        self.score = UserDefaults.standard.integer(forKey: "score")
    }
    
    func increaseScore(int point : Int) {
        score += point
        UserDefaults.standard.set(score, forKey: "score")
    }
}

@main
struct AppTesi1App: App {
    @StateObject var scoreManager = ScoreManager()
    @StateObject var scoreManagerDay = ScoreManagerDay()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(scoreManager)
                .environmentObject(scoreManagerDay)

        }
    }
}


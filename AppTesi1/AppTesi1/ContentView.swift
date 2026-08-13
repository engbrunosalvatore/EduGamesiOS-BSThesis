//
//  ContentView.swift
//  AppTesi1
//
//  Created by Salvatore Bruno on 13/03/23.
//

import SwiftUI
struct ContentView: View {
    @State private var selection: Int? = 0
    
  

    var body: some View {
    
        NavigationView {
            VStack {
               
                TabView(selection: $selection) { // selezione predefinita del tag 0
                    QuizView() // vista del quiz
                        .tabItem {
                            Label("Quiz" , systemImage: "puzzlepiece.extension.fill")
                            
                        }
                        .tag(0)
                    Principale()
                        .tabItem {
                           
                            Label("Minigiochi", systemImage: "gamecontroller.fill")
                           
                        }
                        .tag(1)
                   
                }
                .accentColor(.blue)
                .tabViewStyle(DefaultTabViewStyle())
                .navigationBarTitleDisplayMode(.inline) // Nascondi il titolo della NavigationView in questa sezione
                .font(.title3)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ScoreManager())
            .environmentObject(ScoreManagerDay())
    }
}

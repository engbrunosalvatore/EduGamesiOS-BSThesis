//
//  ContentView.swift
//  ElencoEsercitazioni
//
//  Created by Maurizio Esposito on 15/03/23.
//

import SwiftUI

struct SplashScreenView: View {
    var selection: Binding<Int>
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    @State private var isTapped = false
    @EnvironmentObject var scoreManager : ScoreManager
    
    var body: some View {
        if isFirstLaunch {
            ZStack {
                // Contenuto del tuo ZStack
                // Aggiunge la gif a schermo intero
                VStack{
                    Spacer()
                    GifImage("areaEsercitativa")
                        .edgesIgnoringSafeArea(.all)
                        .gesture(TapGesture().onEnded {
                            isFirstLaunch = false
                            isTapped = true
                        })
                }
                
                // Aggiunge il tap gesture per aprire la OptionsList
                if isTapped {
                    NavigationLink(destination: OptionsList(), isActive: $isTapped) {
                        EmptyView()
                    }
                    .frame(width: 0, height: 0)
                } else {
                    Color.clear
                }
            }
        } else {
            NavigationView {
                OptionsList()
            }
            .navigationBarHidden(true)
        }
    }
}

struct OptionsList: View {
    @EnvironmentObject var scoreManager : ScoreManager
    var body: some View {
        List {
            Text("Punteggio totale: \(scoreManager.score)")
                .font(.system(size: 18))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
            NavigationLink(destination: MathExercisesView()) {
                HStack {
                    Image("Math")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer().frame(width: 30)
                    Text("Matematica")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                }
            }
            NavigationLink(destination: EnglishExercisesView()) {
                HStack {
                    Image("letters")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer().frame(width: 30)
                    Text("Inglese")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                }
            }
            
            NavigationLink(destination: DrawView()) {
                           HStack {
                               Image("Draw") // Aggiunge l'immagine
                                   .resizable()
                                   .frame(width: 100, height: 100) // Imposta la dimensione dell'immagine
                               Spacer().frame(width: 30)
                               Text("Disegna e Colora")
                                   .foregroundColor(.blue)
                                   .font(.system(size: 24))
                           }
                       }
            NavigationLink(destination: TrisGameView()) {
                           HStack {
                               Image("tris") // Aggiunge l'immagine
                                   .resizable()
                                   .frame(width: 100, height: 100) // Imposta la dimensione dell'immagine
                               Spacer().frame(width: 30)
                               Text("Tris")
                                   .foregroundColor(.blue)
                                   .font(.system(size: 24))
                           }
                       }
            NavigationLink(destination: GameView()) {
                           HStack {
                               Image("Monster3") // Aggiunge l'immagine
                                   .resizable()
                                   .frame(width: 100, height: 100) // Imposta la dimensione dell'immagine
                               Spacer().frame(width: 30)
                               Text("Gioca con Rexy")
                                   .foregroundColor(.blue)
                                   .font(.system(size: 24))
                           }
                       }
            
        }
        .navigationBarTitle("Esercizi")
        
    }
}

struct Principale: View {
    @EnvironmentObject var scoreManager : ScoreManager
    @State private var selection = 0 // Aggiungi una variabile di stato per il parametro selection
    
    var body: some View {
        NavigationView {
            SplashScreenView(selection: $selection) // Passa il parametro selection alla vista figlia
                .onDisappear {
                    self.selection = 1
                }
               
        }
    }
}

struct OptionsList_Previews: PreviewProvider {
    static var previews: some View {
        Principale()
            .environmentObject(ScoreManager())
    }
}

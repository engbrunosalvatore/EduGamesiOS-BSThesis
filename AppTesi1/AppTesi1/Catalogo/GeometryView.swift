//
//  GeometryView.swift
//  ElencoEsercitazioni
//
//  Created by Maurizio Esposito on 19/03/23.
//

import SwiftUI

struct ShapeGameView: View {
    @State private var shapes = ["cerchio", "triangolo", "rettangolo", "quadrato", "rombo"]
    @State private var correctShapeIndex = Int.random(in: 0..<3)
    @State private var userScore = 0
    @State private var questionsAsked = 0
    @State private var gameOver = false
    @EnvironmentObject var scoreManager : ScoreManager
    @EnvironmentObject var scoreManagerDay : ScoreManagerDay

    
    var body: some View {
        VStack(spacing: 50) {
            if gameOver {
                VStack {
                    if userScore > 5 {
                        Text("Congratulazioni!")
                            .font(.largeTitle)
                        Image("congrats")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFit()
                    } else {
                        Text("Game Over!")
                            .font(.largeTitle)
                        Image("sad")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFit()
                    }
                    
                    Text("Il tuo punteggio finale è \(userScore)")
                        .font(.headline)
                    
                        Button(action: {
                            self.restartGame()
                        }) {
                            Text("Gioca ancora!")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }.font(.headline)
                    
                    
                }
            } else {
                Text("Quale figura è corretta?")
                    .font(.largeTitle)
                
                Text("\(shapes[correctShapeIndex])")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
                
                HStack(spacing: 10) {
                    ForEach(0..<3) { index in
                        Button(action: {
                            self.checkAnswer(index)
                        }) {
                            Image(systemName: translateText(shapes[index]))
                                .font(.system(size: 100))
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Text("Domanda \(questionsAsked + 1)/10")
                    .font(.headline)
            }
        }
    }
    
    func checkAnswer(_ index: Int) {
        questionsAsked += 1
        
        if index == correctShapeIndex {
            userScore += 1
        }
        
        if questionsAsked == 10 {
            scoreManager.increaseScore(int: userScore)
            scoreManagerDay.increaseScore(int: userScore)

            gameOver = true
        } else {
            shapes.shuffle()
            correctShapeIndex = Int.random(in: 0..<3)
        }
    }
    
    func restartGame() {
        shapes.shuffle()
        correctShapeIndex = Int.random(in: 0..<3)
        userScore = 0
        questionsAsked = 0
        gameOver = false
    }
    
    func translateText(_ text: String) -> String {
        let translations = [
            "rettangolo": "rectangle",
            "triangolo": "triangle",
            "rombo": "rhombus",
            "quadrato": "square",
            "cerchio" : "circle"
        ]
        
        return translations[text.lowercased()] ?? text
    }

}


struct ShapeGameView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeGameView()
    }
}





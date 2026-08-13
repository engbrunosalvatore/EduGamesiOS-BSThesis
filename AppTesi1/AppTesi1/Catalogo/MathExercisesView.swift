//
//  MathExercisesView.swift
//  ElencoEsercitazioni
//
//  Created by Maurizio Esposito on 19/03/23.
//

import SwiftUI

struct MathExercisesView: View {
    var body: some View {
        List {
            NavigationLink(destination: AdditionsGameView()) {
                HStack {
                    Image("addition")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer().frame(width: 30)
                    Text("Addizioni")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                }
            }
            NavigationLink(destination: SubtractionView()) {
                HStack {
                    Image("subtraction")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer().frame(width: 30)
                    Text("Sottrazioni")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                }
            }
            NavigationLink(destination: MultiplicationsView()) {
                HStack {
                    Image("multiplication")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer().frame(width: 30)
                    Text("Moltiplicazioni")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                }
            }
            NavigationLink(destination: DivisionsView()) {
                HStack {
                    Image("division")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer().frame(width: 30)
                    Text("Divisioni")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                }
            }
            NavigationLink(destination: ShapeGameView()) {
                HStack {
                    Image("geometry")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer().frame(width: 30)
                    Text("Geometria")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                }
            }

        }
        .navigationBarTitle("Scegli un argomento")
    }
}


struct AdditionsGameView: View {
    @State private var firstNumber = Int.random(in: 1...10)
    @State private var secondNumber = Int.random(in: 1...10)
    @State private var answer = ""
    @State private var score = 0
    @State private var questionNumber = 1
    @State private var showingAlert = false
    @State private var gameEnded = false
    @State private var isCorrect = false
    @EnvironmentObject var scoreManager : ScoreManager
    @EnvironmentObject var scoreManagerDay : ScoreManagerDay
    
    var body: some View {
        if gameEnded {
            VStack {
                if score >= 3 {
                    Text("Congratulazzioni!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Image("congrats")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                } else {
                    Text("Game Over")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Image("sad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                Text("Il tuo punteggio finale è \(score)")
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
                }
                .font(.headline)
            }
        } else {
            VStack(spacing: 20) {
                //Image("add").resizable().frame(width: 150, height: 150)
                Text("Domanda \(questionNumber)/5")
                    .font(.headline)
                Text("Quanto fa \(firstNumber) + \(secondNumber)?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("La tua risposta", text: $answer)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Invia") {
                    if let userAnswer = Int(answer) {
                        isCorrect = userAnswer == firstNumber + secondNumber
                        if isCorrect{
                            score += 1
                        }
                        showingAlert = true
                    }
                }
            }
            .padding()
            .overlay(
                VStack {
                    if(isCorrect){
                        Text("Corretto!").font(.largeTitle).fontWeight(.bold).padding()
                        GifImage("correct").frame(width: 300,height: 300)
                    }else{
                        Text("Sbagliato").font(.largeTitle).fontWeight(.bold).padding()
                        GifImage("wrong").frame(width: 300,height: 300)
                    }
                    Button(action: {
                        showingAlert = false
                        newQuestion()
                    }) {
                        Text("OK")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .font(.headline)
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.opacity(0.8))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(showingAlert ? 1 : 0)
            )
        }
    }
    
    func restartGame() {
        score = 0
        questionNumber = 0
        gameEnded = false
        newQuestion()
    }
    
    func newQuestion() {
        if questionNumber < 5 {
            questionNumber += 1
            firstNumber = Int.random(in: 1...10)
            secondNumber = Int.random(in: 1...10)
            answer = ""
            isCorrect = false
        }
        else{
            scoreManager.increaseScore(int: score)
            scoreManagerDay.increaseScore(int: score)

            gameEnded=true
        }
    }
}




struct SubtractionView: View {
    @State private var firstNumber = Int.random(in: 10...20)
    @State private var secondNumber = Int.random(in: 1...9)
    @State private var answer = ""
    @State private var score = 0
    @State private var questionNumber = 1
    @State private var showingAlert = false
    @State private var gameEnded = false
    @State private var isCorrect = false
    @EnvironmentObject var scoreManager : ScoreManager
    @EnvironmentObject var scoreManagerDay : ScoreManagerDay

    
    var body: some View {
        if gameEnded {
            VStack {
                if score >= 3 {
                    Text("Congratulazioni!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Image("congrats")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                } else {
                    Text("Game Over")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Image("sad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                Text("Il tuo punteggio finale è \(score)")
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
                }
                .font(.headline)
            }
        } else {
            VStack(spacing: 20) {
                //Image("add").resizable().frame(width: 150, height: 150)
                Text("Domanda \(questionNumber)/5")
                    .font(.headline)
                Text("Quanto fa \(firstNumber) - \(secondNumber)?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("La tua risposta", text: $answer)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Invia") {
                    if let userAnswer = Int(answer) {
                        isCorrect = userAnswer == firstNumber - secondNumber
                        if isCorrect{
                            score += 1
                        }
                        showingAlert = true
                    }
                }
            }
            .padding()
            .overlay(
                VStack {
                    if(isCorrect){
                        Text("Corretto!").font(.largeTitle).fontWeight(.bold).padding()
                        GifImage("correct").frame(width: 300,height: 300)
                    }else{
                        Text("Sbagliato").font(.largeTitle).fontWeight(.bold).padding()
                        GifImage("wrong").frame(width: 300,height: 300)
                    }
                    Button(action: {
                        showingAlert = false
                        newQuestion()
                    }) {
                        Text("OK")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .font(.headline)
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.opacity(0.8))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(showingAlert ? 1 : 0)
            )
        }
    }
    
    func restartGame() {
        score = 0
        questionNumber = 0
        gameEnded = false
        newQuestion()
    }
    
    func newQuestion() {
        if questionNumber < 5 {
            questionNumber += 1
            firstNumber = Int.random(in: 1...20)
            secondNumber = Int.random(in: 1..<firstNumber)
            answer = ""
            isCorrect = false
        }
        else{
            scoreManager.increaseScore(int: score)
            scoreManagerDay.increaseScore(int: score)

            gameEnded=true
            
        }
    }
}


struct MultiplicationsView: View {
    @State private var firstNumber = Int.random(in: 0...10)
    @State private var secondNumber = Int.random(in: 0...10)
    @State private var answer = ""
    @State private var score = 0
    @State private var questionNumber = 1
    @State private var showingAlert = false
    @State private var gameEnded = false
    @State private var isCorrect = false
    @EnvironmentObject var scoreManager : ScoreManager
    @EnvironmentObject var scoreManagerDay : ScoreManagerDay

    
    var body: some View {
        if gameEnded {
            VStack {
                if score >= 3 {
                    Text("Congratulazioni!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Image("congrats")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                } else {
                    Text("Game Over")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Image("sad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                Text("Il tuo punteggio finale è \(score)")
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
                }
                .font(.headline)
            }
        } else {
            VStack(spacing: 20) {
                //Image("add").resizable().frame(width: 150, height: 150)
                Text("Domanda \(questionNumber)/5")
                    .font(.headline)
                Text("Quanto fa \(firstNumber) x \(secondNumber)?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("La tua risposta", text: $answer)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Invia") {
                    if let userAnswer = Int(answer) {
                        isCorrect = userAnswer == firstNumber * secondNumber
                        if isCorrect{
                            score += 1
                        }
                        showingAlert = true
                    }
                }
            }
            .padding()
            .overlay(
                VStack {
                    if(isCorrect){
                        Text("Corretto!").font(.largeTitle).fontWeight(.bold).padding()
                        GifImage("correct").frame(width: 300,height: 300)
                    }else{
                        Text("Sbagliato").font(.largeTitle).fontWeight(.bold).padding()
                        GifImage("wrong").frame(width: 300,height: 300)
                    }
                    Button(action: {
                        showingAlert = false
                        newQuestion()
                    }) {
                        Text("OK")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .font(.headline)
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.opacity(0.8))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(showingAlert ? 1 : 0)
            )
        }
    }
    
    func restartGame() {
        score = 0
        questionNumber = 0
        gameEnded = false
        newQuestion()
    }
    
    func newQuestion() {
        if questionNumber < 5 {
            questionNumber += 1
            firstNumber = Int.random(in: 0...10)
            secondNumber = Int.random(in: 0...10)
            answer = ""
            isCorrect = false
        }
        else{
            scoreManager.increaseScore(int: score)
            scoreManagerDay.increaseScore(int: score)

            gameEnded=true
        }
    }
}

struct DivisionsView: View {
    @State private var firstNumber = Int.random(in: 0...10)
    @State private var secondNumber = Int.random(in: 1...10)
    @State private var answer = ""
    @State private var score = 0
    @State private var questionNumber = 1
    @State private var showingAlert = false
    @State private var gameEnded = false
    @State private var isCorrect = false
    @EnvironmentObject var scoreManager : ScoreManager
    @EnvironmentObject var scoreManagerDay : ScoreManagerDay

    
    var body: some View {
        if gameEnded {
            VStack {
                if score >= 3 {
                    Text("Congratulazioni!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Image("congrats")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                } else {
                    Text("Game Over")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Image("sad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                Text("Il tuo punteggio finale è \(score)")
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
                }
                .font(.headline)
            }
        } else {
            VStack(spacing: 20) {
                Text("Domanda \(questionNumber)/5")
                    .font(.headline)
                Text("Quanto fa \(firstNumber * secondNumber ) : \(secondNumber)?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("La tua risposta", text: $answer)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Invia") {
                    if let userAnswer = Int(answer) {
                        isCorrect = userAnswer == firstNumber*secondNumber / secondNumber
                        if isCorrect{
                            score += 1
                        }
                        showingAlert = true
                    }
                }
            }
            .padding()
            .overlay(
                VStack {
                    if(isCorrect){
                        Text("Corretto!").font(.largeTitle).fontWeight(.bold).padding()
                        GifImage("correct").frame(width: 300,height: 300)
                    }else{
                        Text("Sbagliato").font(.largeTitle).fontWeight(.bold).padding()
                        GifImage("wrong").frame(width: 300,height: 300)
                    }
                    Button(action: {
                        showingAlert = false
                        newQuestion()
                    }) {
                        Text("OK")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .font(.headline)
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.opacity(0.8))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(showingAlert ? 1 : 0)
            )
        }
    }
    
    func restartGame() {
        score = 0
        questionNumber = 0
        gameEnded = false
        newQuestion()
    }
    
    func newQuestion() {
        if questionNumber < 5 {
            questionNumber += 1
            firstNumber = Int.random(in: 0...10)
            secondNumber = Int.random(in: 1...10)
            answer = ""
            isCorrect = false
        }
        else{
            scoreManager.increaseScore(int: score)
            scoreManagerDay.increaseScore(int: score)

            gameEnded=true
        }
    }
}


struct MathExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        MathExercisesView()
    }
}


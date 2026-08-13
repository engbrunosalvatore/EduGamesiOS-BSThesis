//
//  EnglishExercisesView.swift
//  ElencoEsercitazioni
//
//  Created by Maurizio Esposito on 23/03/23.
//

import SwiftUI

struct EnglishExercisesView: View {
    var body: some View {
        List {
            NavigationLink(destination: EnglishWordMatchView()) {
                HStack {
                    Image("whatis")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer().frame(width: 30)
                    Text("Trova la parola")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                }
            }
            NavigationLink(destination: QuestionView()) {
                HStack {
                    Image("questionmark")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer().frame(width: 30)
                    Text("Che cos'è?")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                }
            }
            NavigationLink(destination: HangmanView()) {
                HStack {
                    Image("hangman")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Spacer().frame(width: 30)
                    Text("L'impiccato")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                }
            }

        }
        .navigationBarTitle("Scegli un gioco")
    }
}

struct EnglishWordMatchView: View {
    @State private var words = ["apple", "ball", "cat", "dog", "egg", "fish", "guitar", "hat", "key", "lion", "monkey", "pencil", "queen", "rabbit", "sun", "turtle", "umbrella", "zebra"]
    
    @State private var correctImageIndex = Int.random(in: 0..<3)
    @State private var selectedImageIndex: Int?
    @State private var userScore = 0
    @State private var isCorrect = false
    @State private var questionsAsked = 0
    @State private var showingAlert = false
    @State private var gameOver = false
    @EnvironmentObject var scoreManager : ScoreManager
    @EnvironmentObject var scoreManagerDay : ScoreManagerDay

    
    var body: some View {
        VStack(spacing: 50) {
            Text("Qual è l'immagine giusta?")
                .font(.largeTitle)
            
            Text("\(words[correctImageIndex])")
                .font(.system(size: 40))
                .foregroundColor(.blue)
            
            HStack(spacing: 10) {
                ForEach(0..<3) { index in
                    Button(action: {
                        self.checkAnswer(index)
                        self.selectedImageIndex = index // set the selectedImageIndex when button is tapped
                    }) {
                        Image(words[index])
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedImageIndex == index ? (isCorrect ? Color.green : Color.red) : Color.gray, lineWidth: 2) // change the stroke color based on whether the image is selected and if it's correct or not
                            )
                    }
                }
            }
        }
        .overlay(
            VStack {
                if(isCorrect){
                    Text("Corretto!").font(.largeTitle).fontWeight(.bold).padding()
                    GifImage("correct").frame(width: 300,height: 300)
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
    
    func checkAnswer(_ index: Int) {
        if index == correctImageIndex {
            isCorrect = true
            showingAlert = true
            scoreManager.increaseScore(int: 1)
            scoreManagerDay.increaseScore(int: 1)

        } else {
            isCorrect = false // set isCorrect to false
            selectedImageIndex = index // set the selectedImageIndex to display the red stroke color
        }
    }
    
    func newQuestion() {
        words.shuffle()
        correctImageIndex = Int.random(in: 0..<3)
        isCorrect = false
        selectedImageIndex = nil
    }
}



    
    struct QuestionView: View {
        
        let questions = [Question(imageName: "banana", correctAnswer: "Banana"),
                         Question(imageName: "cat", correctAnswer: "Cat"),
                         Question(imageName: "dog", correctAnswer: "Dog"),
                         Question(imageName: "elephant", correctAnswer: "Elephant"),
                         Question(imageName: "fish", correctAnswer: "Fish"),
                         Question(imageName: "glasses", correctAnswer: "Glasses"),
                         Question(imageName: "house", correctAnswer: "House"),
                         Question(imageName: "key", correctAnswer: "Key"),
                         Question(imageName: "lemon", correctAnswer: "Lemon"),
                         Question(imageName: "mouse", correctAnswer: "Mouse"),
                         Question(imageName: "nose", correctAnswer: "Nose"),
                         Question(imageName: "orange", correctAnswer: "Orange"),
                         Question(imageName: "sun", correctAnswer: "Sun")]
        @State private var randomIm = Int.random(in: 0...11)
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
                        Text("Congratulations!")
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
                    Text("Your final score is \(score)")
                        .font(.headline)
                    
                    Button(action: {
                        self.restartGame()
                    }) {
                        Text("Play Again!")
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
                    Text("Question \(questionNumber)/5")
                        .font(.headline)
                    Text("Write the name of the image:")
                        .fontWeight(.bold)
                    
                    Image(questions[randomIm].imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    TextField("Your answer", text: $answer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Submit") {
                        if answer == questions[randomIm].correctAnswer {
                            isCorrect = true
                            if isCorrect{
                                score += 1
                            }
                        }
                        showingAlert = true
                    }
                }
                .padding()
                .overlay(
                    VStack {
                        if(isCorrect){
                            Text("Correct!").font(.largeTitle).fontWeight(.bold).padding()
                            GifImage("correct").frame(width: 300,height: 300)
                        }else{
                            Text("Wrong").font(.largeTitle).fontWeight(.bold).padding()
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
                randomIm = Int.random(in: 0...11)
                answer = ""
                isCorrect = false
            }
            else{
                scoreManager.increaseScore(int: score)
                scoreManagerDay.increaseScore(int: score)

                gameEnded=true
            }
        }
        
        struct Question {
            var imageName: String
            var correctAnswer: String
        }
        
        struct EnglishExercisesView_Previews: PreviewProvider {
            static var previews: some View {
                EnglishExercisesView()
            }
        }
    }

//
//  ContentView.swift
//  AppTesi1
//
//  Created by Salvatore Bruno on 18/03/23.
//


import SwiftUI


struct QuizHomePageView: View {
    @EnvironmentObject var scoreManager : ScoreManager
    @EnvironmentObject var scoreManagerDay : ScoreManagerDay

     
    @StateObject var quiz = Quiz()
    @State var currentQuestionIndex = 0
    @State private var selectedAnswerIndex: Int? = nil
    @State var isShowingResult = false
    @State var isShowingCongratulations = false
    @Environment(\.dismiss) private var dismiss
    
    
    @State var score = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                VStack {
                    if isShowingCongratulations {
                        // Mostra il messaggio di congratulazioni al termine delle domande
                        Text("Complimenti, hai finito il quiz!")
                            .font(.title)
                            .padding()
                    } else {
                        // Mostra la prossima domanda
                        Text(quiz.questions[currentQuestionIndex].text)
                            .font(.title)
                            .padding()
                            .fixedSize(horizontal: false, vertical: true)
                            
                        ForEach(0..<quiz.questions[currentQuestionIndex].answers.count, id: \.self) { index in
                            Button(action: {
                                selectedAnswerIndex = index
                            }) {
                                VStack{
                                    Text(quiz.questions[currentQuestionIndex].answers[index])
                                        .padding()
                                        .frame(width: 300) // Aggiungi una larghezza fissa alle risposte
                                        .foregroundColor(selectedAnswerIndex == index ? .white : .black)
                                        .background(selectedAnswerIndex == index ? Color.blue : Color.gray.opacity(0.3))
                                        .cornerRadius(10)
                                        .fixedSize(horizontal: false, vertical: true) // Imposta la stessa altezza per tutte le risposte
                                    
                                    
                                    Spacer()
                                    
                                }
                                .padding(.vertical, 5)
                               
                            }
                           
                        }
                        GifImage("mostro2")
                            .frame(width: 200, height: 200)

                        
                        Spacer()
                        
                        Button(action: {
                            if let selectedAnswerIndex = selectedAnswerIndex {
                                if quiz.questions[currentQuestionIndex].correctAnswer == selectedAnswerIndex {
                                    // Aggiungi 40 punti per la risposta corretta
                                    score += 40
                                }
                                
                                currentQuestionIndex += 1
                                if currentQuestionIndex >= quiz.questions.count {
                                    // Tutte le domande sono state risposte, mostra il messaggio di congratulazioni
                                    isShowingCongratulations = true
                                    scoreManager.increaseScore(int: score)
                                    scoreManagerDay.increaseScore(int: score)

                                }
                                self.selectedAnswerIndex = nil
                            }
                        }) {
                            Text(isShowingCongratulations ? "Risultato" : "Avanti")
                                .padding()
                                .foregroundColor(.white)
                                .background(selectedAnswerIndex == nil ? Color.gray : Color.blue)
                                .cornerRadius(8)
                        }
                        .disabled(selectedAnswerIndex == nil)
                        .padding(.bottom)
                    }
                }
                
                Spacer()
                
                if isShowingCongratulations {
                    // Show the "Torna alla Home" button only when the quiz is finished
                    GifImage("mostro2")
                    VStack {
                        Text("Punteggio totale: \(score)")
                            .font(.headline)
                            .padding()
                        
                        NavigationLink(destination: ContentView(), label: {
                            Text("Torna alla Home")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(8)
                                .onTapGesture {
                                    dismiss()
                                }
                         
                        })
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
                }
                
            }
            .navigationTitle("Quiz del giorno")
            
            .navigationBarItems(trailing:
                HStack{
                    VStack {
                        Text("Progresso")
                            .font(.caption)
                        ProgressBar(percent: CGFloat(currentQuestionIndex) / CGFloat(quiz.questions.count) * 100)
                            .alignmentGuide(HorizontalAlignment.leading) { d in d[.leading] }
                        .frame(height: 20)
                    }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            
                

            
                
            }
                            )
            
           ProgressView()
        
            
        }
        
        
    }
    func calculateScore() -> Int {
        var score = 0
        for index in 0..<quiz.questions.count {
            if quiz.questions[index].correctAnswer == selectedAnswerIndex {
                score += 1
            }
        }
        return score
    }
}


struct Question {
    let prompt: String
    let choices: [String]
    let correctAnswerIndex: Int
}

struct QuizHomePageView_Previews: PreviewProvider {
    static var previews: some View {
        QuizHomePageView()
    }
}

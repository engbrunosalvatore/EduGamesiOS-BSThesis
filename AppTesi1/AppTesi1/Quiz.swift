//
//  Quiz.swift
//  AppTesi1
//
//  Created by Salvatore Bruno on 15/03/23.
//

import Foundation

class Quiz : ObservableObject {
    struct Question {
        var text: String
        var answers: [String]
        var correctAnswer: Int
        var difficulty: Int // Aggiunto livello di difficoltà
    }


    
    @Published var questions: [Question]
    
    init() {
        let allQuestions = [
            Question(text: "Qual è il colore del sole?", answers: ["Rosso", "Giallo", "Blu"], correctAnswer: 1, difficulty: 1),
            Question(text: "Quanti giorni ci sono in una settimana?", answers: ["5", "6", "7"], correctAnswer: 2, difficulty: 2),
            Question(text: "Quale animale fa il verso 'miao'?", answers: ["Cane", "Gatto", "Uccello"], correctAnswer: 1, difficulty: 1),
            Question(text: "Qual è la capitale dell'Italia?", answers: ["Roma", "Milano", "Napoli"], correctAnswer: 0, difficulty: 2),
            Question(text: "Chi è il protagonista del cartone animato SpongeBob?", answers: ["SpongeBob", "Patrick", "Squidward"], correctAnswer: 0, difficulty: 1),
            Question(text: "Quanti occhi ha una mosca?", answers: ["2", "4", "6"], correctAnswer: 0, difficulty: 2),
            Question(text: "Come si chiama il famoso mago con la cicatrice sulla fronte?", answers: ["Harry Potter", "Ron Weasley", "Hermione Granger"], correctAnswer: 0, difficulty: 1),
            Question(text: "Qual è il nome dell'oceano più grande del mondo?", answers: ["Oceano Pacifico", "Oceano Indiano", "Oceano Atlantico"], correctAnswer: 0,difficulty: 2),
            Question(text: "Qual è il frutto che cresce sugli alberi e ha la buccia gialla?", answers: ["Ciliegia", "Banana", "Arancia"], correctAnswer: 1,difficulty: 1),
            Question(text: "Come si chiama l'uccello che simboleggia la pace?", answers: ["Gabbiano", "Colomba", "Falco"], correctAnswer: 1,difficulty: 2),
            Question(text: "Quale animale è conosciuto per il suo lungo collo?", answers: ["Giraffa", "Ippopotamo", "Elefante"], correctAnswer: 0,difficulty: 1),
            Question(text: "In quale stagione le foglie degli alberi cadono?", answers: ["Primavera", "Estate", "Autunno"], correctAnswer: 2,difficulty: 2),
            Question(text: "Qual è il nome del nostro satellite naturale?", answers: ["Marte", "Luna", "Venere"], correctAnswer: 1, difficulty: 2),
            Question(text: "Quale strumento si usa per suonare la batteria?", answers: ["Chitarra", "Pianoforte", "Bacchette"], correctAnswer: 2,difficulty: 1),
            Question(text: "Qual è il nome della principessa del Regno dei ghiacci?", answers: ["Anna", "Elsa", "Olaf"], correctAnswer: 1,difficulty: 1),
            Question(text: "Qual è il nome della famosa topolina creata da Walt Disney?", answers: ["Minnie", "Daisy", "Clarabella"], correctAnswer: 0,difficulty: 1),
            Question(text: "In quale sport si usa la palla e la rete?", answers: ["Calcio", "Nuoto", "Carambola"], correctAnswer: 1,difficulty: 2),
            Question(text: "Quale animale simboleggia la saggezza?", answers: ["Cane", "Gatto", "Gufo"], correctAnswer: 2,difficulty: 1),
            Question(text: "Qual è il nome del mostro verde che appare nei film?", answers: ["Hulk", "Iron Man", "Spider-Man"], correctAnswer: 0,difficulty: 1),
            Question(text: "Come si chiama l'animale che salta in lungo e in largo?", answers: ["Leone", "Canguro", "Iena"], correctAnswer: 1, difficulty: 2)

        ]
        
        
              let shuffledQuestions = allQuestions.shuffled() // Mescola le domande
                
                questions = Array(shuffledQuestions.prefix(5)) // Prende solo i primi 5 elementi
    }

      
}


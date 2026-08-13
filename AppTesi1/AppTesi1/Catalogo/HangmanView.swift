//
//  CrosswordView.swift
//  ElencoEsercitazioni
//
//  Created by Maurizio Esposito on 23/03/23.
//
import SwiftUI


struct HangmanView: View {
    @State private var displayWord = ""
    @State private var wrongLetters = ""
    @State private var guess = ""
    @State private var word = ""
    @State private var wrongLettersArray: [Character] = []
    @State private var usedLetters: [Character] = []
    @State private var displayWordArray: [Character] = []
    @State private var hangmanImage: UIImage?
    @State private var gameImage: UIImage?
    @State private var isGameOver = false
    @State private var youWin = false
    @State private var gameEnded = false
    @EnvironmentObject var scoreManager : ScoreManager
    @EnvironmentObject var scoreManagerDay : ScoreManagerDay

    
    let wordArray = ["JUICE", "CHANGE", "GUITAR", "BANANA", "POLICE","RABBIT", "MARTIN", "HAMMER", "CARROT", "GUITAR", "BASKET","PUMPKIN", "ROCKET", "POPCORN", "WINDOW", "MARKER", "RACOON","RUMBLE", "DINING", "BADGER", "HOCKEY", "PLANTS", "LIZARD","JACKET", "ORANGE", "HAMPER", "BRIDGE", "KITTEN", "PUZZLE"]
    
    var body: some View {
        if gameEnded {
            VStack {
                if youWin{
                    Text("Congratulations!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("+50 points")
                        .font(.largeTitle)
                    Image("congrats")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                } else {
                    Text("Game Over")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("The right word was \(word).")
                    Image("sad")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                Button(action: resetButtonPressed) {
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
            VStack {
                Text(displayWord)
                    .font(.largeTitle)
                    .padding()
                Text(wrongLetters)
                    .padding()
                HStack {
                    TextField("Enter a letter", text: $guess)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                    Button(action: guessButtonPressed) {
                        Text("Submit")
                    }
                }
                Spacer()
                Image(uiImage: hangmanImage ?? UIImage(named: "pic1")!)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()
                if isGameOver {
                    Image(uiImage: UIImage(named: "gameOver")!)
                        .resizable()
                        .frame(width: 150, height: 150)
                    
                }
            }
            .onAppear(perform: viewDidLoad)
        }
    }
        
        func viewDidLoad() {
            resetButtonPressed()
        }
        
    func guessButtonPressed() {
        guess = guess.uppercased()
        if guess.isEmpty {
            return
        }

        guard guess.count == 1 else {
            guessTextFieldError("Enter one letter")
            return
        }

        checkForLetter()
        displayWord = String(displayWordArray)
        guess = ""
        checkForWin()

        if wrongLettersArray.count == 8 && displayWord.contains("?") {
            isGameOver = true
            gameEnded = true
        }
    }

    func resetButtonPressed() {
        guess = ""
        wrongLettersArray = []
        wrongLetters = ""
        displayWord = ""
        isGameOver = false
        word = wordArray.randomElement()!
        usedLetters = Array(word)
        for letters in 1...word.count{
            displayWord += "?"
            displayWordArray = Array(displayWord)
        }
        gameEnded = false
        hangmanImage = UIImage(named: "pic0")
    }

        
        func guessTextFieldError(_ message: String) {
            guess = ""
            // Placeholder doesn't work for SwiftUI TextField, so using an alert to display the error message
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        }
        
        func checkForLetter() {
            if usedLetters.contains(Character(guess)) {
                for i in 0..<word.count {
                    if guess.first == usedLetters[i] {
                        displayWordArray[i] = Character(guess)
                    }
                }
            } else {
                wrongLettersArray.append(Character(guess))
                wrongLetters = String(wrongLettersArray)
                placeImage()
            }
        }
        
        func placeImage() {
            let imageName = "pic\(wrongLettersArray.count+1)"
            gameImage = UIImage(named: imageName)
            hangmanImage = gameImage
        }
        
        func checkForWin() {
            if !displayWordArray.contains("?") {
                scoreManager.increaseScore(int: 50)
                scoreManagerDay.increaseScore(int: 50)

                youWin = true
                gameEnded=true
            } else if wrongLettersArray.count == 8 {
                isGameOver = true
                gameEnded = true
            }
        }
        
        
    }

struct HangmanView_Previews: PreviewProvider {
    static var previews: some View {
        HangmanView()
    }
}




//
//  TrisGameView.swift
//  ElencoEsercitazioni
//
//  Created by Maurizio Esposito on 25/03/23.
//

//NUOVO
import SwiftUI

struct TrisGameView: View {
    @StateObject var gameState = GameState()
    @State private var isSinglePlayer = true
    @StateObject var computerPlayer = ComputerPlayer()
    
        var body: some View
    {
        VStack(){
            if isSinglePlayer == false {
                if gameState.gameOver{
                    VStack{
                        if gameState.win == "croci"{
                            Text("Vittoria delle CROCI!")
                                .font(.largeTitle)
                            Image("congrats")
                                .resizable()
                                .frame(width: 300, height: 300)
                                .scaledToFit()
                        }else if gameState.win == "cerchi"{
                            Text("Vittoria dei CERCHI!")
                                .font(.largeTitle)
                            Image("congrats")
                                .resizable()
                                .frame(width: 300, height: 300)
                                .scaledToFit()
                        }else{
                            Text("Pareggio")
                                .font(.largeTitle)
                            Image("sad")
                                .resizable()
                                .frame(width: 300, height: 300)
                                .scaledToFit()
                        }
                        Button(action: {
                            gameState.resetBoard()
                        }) {
                            Text("Gioca ancora!")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }.font(.headline)
                    }
                }else{
                    let borderSize = CGFloat(5)
                    
                    Text(gameState.turnText())
                        .font(.title)
                        .bold()
                        .padding()
                    Spacer()
                    
                    Text(String(format: "Croci: %d", gameState.crossesScore))
                        .font(.title)
                        .bold()
                        .padding()
                    
                    VStack(spacing: borderSize)
                    {
                        ForEach(0...2, id: \.self)
                        {
                            row in
                            HStack(spacing: borderSize)
                            {
                                ForEach(0...2, id: \.self)
                                {
                                    column in
                                    
                                    let cell = gameState.board[row][column]
                                    
                                    Text(cell.displayTile())
                                        .font(.system(size: 60))
                                        .foregroundColor(cell.tileColor())
                                        .bold()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .aspectRatio(1, contentMode: .fit)
                                        .background(Color.white)
                                        .onTapGesture {
                                            gameState.placeTile(row, column)
                                        }
                                }
                            }
                            
                        }
                    }
                    .background(Color.black)
                    .padding()
                    
                    Text(String(format: "Cerchi: %d", gameState.noughtsScore))
                        .font(.title)
                        .bold()
                        .padding()
                    Spacer()
                }
            }else{
                //Modalità ad un giocatore
                if gameState.gameOver{
                    VStack{
                        if gameState.win == "croci"{
                            Text("Vittoria delle CROCI!")
                                .font(.largeTitle)
                            Image("congrats")
                                .resizable()
                                .frame(width: 300, height: 300)
                                .scaledToFit()
                        }else if gameState.win == "cerchi"{
                            Text("Vittoria dei CERCHI!")
                                .font(.largeTitle)
                            Image("congrats")
                                .resizable()
                                .frame(width: 300, height: 300)
                                .scaledToFit()
                        }else{
                            Text("Pareggio")
                                .font(.largeTitle)
                            Image("sad")
                                .resizable()
                                .frame(width: 300, height: 300)
                                .scaledToFit()
                        }
                        Button(action: {
                            gameState.resetBoardOnePlayer()
                        }) {
                            Text("Gioca ancora!")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }.font(.headline)
                    }
                }else{
                    let borderSize = CGFloat(5)
                    
                    Text(gameState.turnText())
                        .font(.title)
                        .bold()
                        .padding()
                    Spacer()
                    
                    Text(String(format: "Croci: %d", gameState.crossesScore))
                        .font(.title)
                        .bold()
                        .padding()
                    
                    VStack(spacing: borderSize) {
                        ForEach(0...2, id: \.self) { row in
                            HStack(spacing: borderSize) {
                                ForEach(0...2, id: \.self) { column in
                                    let cell = gameState.board[row][column]
                                    Text(cell.displayTile())
                                        .font(.system(size: 60))
                                        .foregroundColor(cell.tileColor())
                                        .bold()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .aspectRatio(1, contentMode: .fit)
                                        .background(Color.white)
                                        .onTapGesture {
                                            gameState.placeTile(row, column)
                                            if !gameState.gameOver && gameState.turn == .Nought {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                    computerPlayer.makeMove(gameState: gameState)
                                                }
                                            }
                                        }
                                }
                            }
                        }
                    }.background(Color.black)
                        .padding()
                    
                    Text(String(format: "Cerchi: %d", gameState.noughtsScore))
                        .font(.title)
                        .bold()
                        .padding()
                    Spacer()
                }
            }
        }
        Picker("Modalità di gioco", selection: $isSinglePlayer) {
            Text("Giocatore Singolo").tag(true)
            Text("Due Giocatori").tag(false)
        }
        .pickerStyle(.segmented)
        .onChange(of: isSinglePlayer) { value in
            gameState.resetBoardOnePlayer()
            gameState.noughtsScore = 0
            gameState.crossesScore = 0
        }

    }
}

struct Cell
{
    var tile: Tile
    
    func displayTile() -> String
    {
        switch(tile)
        {
            case Tile.Nought:
                    return "O"
            case Tile.Cross:
                return "X"
            default:
                return ""
        }
    }
    
    func tileColor() -> Color
    {
        switch(tile)
        {
            case Tile.Nought:
                return Color.red
            case Tile.Cross:
                return Color.black
            default:
                return Color.black
        }
    }
}

enum Tile
{
    case Nought
    case Cross
    case Empty
}

class GameState: ObservableObject
{
    @Published var board = [[Cell]]()
    @Published var turn = Tile.Cross
    @Published var noughtsScore = 0
    @Published var crossesScore = 0
    @Published var win = "nessuno"
    @Published var gameOver = false
    @Published var computerPlayer = ComputerPlayer()

    
    
    
    init()
    {
        resetBoard()
    }
    
    func turnText() -> String
    {
        return turn == Tile.Cross ? "Turno: X" : "Turno: O"
    }
    
    func placeTile(_ row: Int,_ column: Int)
    {
        if(board[row][column].tile != Tile.Empty)
        {
            return
        }
        
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Nought
        
        if(checkForVictory())
        {
            if(turn == Tile.Cross)
            {
                crossesScore += 1
            }
            else
            {
                noughtsScore += 1
            }
            win = turn == Tile.Cross ? "croci" : "cerchi"
            gameOver = true

        }
        else
        {
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }

        if(checkForDraw() && !gameOver) // Aggiunta la condizione !gameOver
        {
            win = "Pareggio"
            gameOver = true
        }

    }
    
    func checkForDraw() -> Bool
    {
        for row in board
        {
            for cell in row
            {
                if cell.tile == Tile.Empty
                {
                    return false
                }
            }
        }
        
        return true
    }
    
    func checkForVictory() -> Bool
    {
        // vertical victory
        if isTurnTile(0, 0) && isTurnTile(1, 0) && isTurnTile(2, 0)
        {
            return true
        }
        if isTurnTile(0, 1) && isTurnTile(1, 1) && isTurnTile(2, 1)
        {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 2) && isTurnTile(2, 2)
        {
            return true
        }
        
        // horizontal victory
        if isTurnTile(0, 0) && isTurnTile(0, 1) && isTurnTile(0, 2)
        {
            return true
        }
        if isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(1, 2)
        {
            return true
        }
        if isTurnTile(2, 0) && isTurnTile(2, 1) && isTurnTile(2, 2)
        {
            return true
        }
        
        // diagonal victory
        if isTurnTile(0, 0) && isTurnTile(1, 1) && isTurnTile(2, 2)
        {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 1) && isTurnTile(2, 0)
        {
            return true
        }
        
        
        return false
    }
    
    func isTurnTile(_ row: Int,_ column: Int) -> Bool
    {
        return board[row][column].tile == turn
    }
    func resetBoardOnePlayer(){
        var newBoard = [[Cell]]()
        
        for _ in 0...2
        {
            var row = [Cell]()
            for _ in 0...2
            {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
        turn = Tile.Cross
        gameOver = false
        win = "nessuno"
    }
    func resetBoard()
    {
        var newBoard = [[Cell]]()
        
        for _ in 0...2
        {
            var row = [Cell]()
            for _ in 0...2
            {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
        gameOver = false
        win = "nessuno"
    }
    func computerMove() {
        computerPlayer.makeMove(gameState: self)
    }
}
class ComputerPlayer : ObservableObject {
    func makeMove(gameState: GameState) {
        var availableCells: [(Int, Int)] = []
        for row in 0...2 {
            for column in 0...2 {
                if gameState.board[row][column].tile == .Empty {
                    availableCells.append((row, column))
                }
            }
        }
        if availableCells.count > 0 {
            let randomIndex = Int.random(in: 0..<availableCells.count)
            let (row, column) = availableCells[randomIndex]
            gameState.placeTile(row, column)
        }
    }
}

struct TrisGameView_Previews: PreviewProvider {
    static var previews: some View {
        TrisGameView()
    }
}


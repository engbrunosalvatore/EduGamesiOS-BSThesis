//
//  GameView.swift
//  AppTesi1
//
//  Created by Salvatore Bruno on 12/04/23.
//
import SwiftUI
import GameplayKit

struct GameView: View {
    @EnvironmentObject var scoreManager : ScoreManager
    @EnvironmentObject var scoreManagerDay : ScoreManagerDay


    @State private var score = 0
    @State var getScore = 0
    
    @State var isGameStart : Bool = false
    @State var rexyPosY = 0.0
    
    @State var rexyMoment : RexyCases = .walk
    @State var hitbox = false

    var body: some View {
        ZStack{
            CloudsView()
            OpponentsView(hitbox: $hitbox, isGameStart: $isGameStart, getScore: $getScore, rexyPosY: $rexyPosY, rexyMoment: $rexyMoment)
                .offset(y: -39)
            scoreLabel
            
            GroundView(rexyMoment: $rexyMoment)
                .offset(y: 39)
            RexyView(rexyPosY: $rexyPosY, rexyMoment: $rexyMoment, isGameStart: $isGameStart)
            replayButton
                
        }
    }
}
extension GameView {
    private var scoreLabel: some View {
        HStack {
            Text("Score \(String(format: "%.5d", getScore))")
                .font(Font.custom("HelveticaNeue-Bold", size: 28))
                .fontWeight(.bold)
                .foregroundColor(.blue.opacity(0.5))
                .shadow(color: Color.blue.opacity(0.3), radius: 3, x: 0, y: 3)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
        .background(Color(.systemGray6))
        .cornerRadius(16)
        .frame(maxWidth: 350, maxHeight: .infinity, alignment: .topTrailing)
        .padding()
        .zIndex(1)
    }

    private var replayButton: some View {
        VStack{
            Spacer()
            if rexyMoment == .gameOver {
                Button {
                    scoreManager.increaseScore(int: getScore)
                    scoreManagerDay.increaseScore(int: getScore)

                    rexyPosY = -7
                    rexyMoment = .walk
                    hitbox = false
                    isGameStart = true
                    score = 0
                    getScore = 0
                    
                } label: {
                    VStack{
                        
                        Image("btnRetry")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 72)
                        Text("Salva e Riprova".uppercased())
                            .font(.title2)
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        

    }
}
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

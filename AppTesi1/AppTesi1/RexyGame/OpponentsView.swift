//
//  OpponentsView.swift
//  AppTesi1
//
//  Created by Salvatore Bruno on 12/04/23.
//

import SwiftUI
struct OpponentsView : View {
    @State private var posX : Double = 0
    @State private var posXs : [Double] = [0.0,0.0,0.0,0]
    
    @State private var maxX: Double = 500
    @State private var minX: Double = -500
    
    @State var speed: Double = 15.0
    
    let range = 92.0...192
    
    @State var changeIt = false
    
    @Binding var hitbox: Bool
    
    @Binding var isGameStart : Bool
    @Binding var getScore : Int
    @Binding var rexyPosY : Double
    @Binding var rexyMoment : RexyCases

    let timer = Timer.publish(every: 0.007, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack{
            ObstaclePrefab(changeIt: $changeIt, posX: $posXs[0], hitbox: $hitbox, getScore: $getScore, rexyPosY: $rexyPosY, rexyMoment: $rexyMoment)
                .position(x: posXs[0], y: 96)
            ObstaclePrefab(changeIt: $changeIt, posX: $posXs[1], hitbox: $hitbox, getScore: $getScore, rexyPosY: $rexyPosY, rexyMoment: $rexyMoment)
                .position(x: posXs[1], y: 96)
            ObstaclePrefab(changeIt: $changeIt, posX: $posXs[2], hitbox: $hitbox, getScore: $getScore, rexyPosY: $rexyPosY, rexyMoment: $rexyMoment)
                .position(x: posXs[2], y: 96)
            ObstaclePrefab(changeIt: $changeIt, posX: $posXs[3], hitbox: $hitbox, getScore: $getScore, rexyPosY: $rexyPosY, rexyMoment: $rexyMoment)
                .position(x: posXs[3], y: 96)
            
            
        }
        .onAppear{
            changeIt.toggle()
            posX = maxX
            posXs = [posX, posX+258, posX+592, posX+900]
        }
        .onReceive(timer) { _ in
            
            if isGameStart && !hitbox {
                
                posX -= 1
                posXs = [posX, posX+258, posX+592, posX+900]
                
                if posX < -990 {
                    posX = maxX
                }
            }
        }
        .onChange(of: hitbox, perform: { newValue in
            if newValue == false {
                posX = maxX
                posXs = [posX, posX+258, posX+592, posX+900]
            }
        })
        .frame(width: 430,height: 192)
        .clipped()
     
        
    }
}

private struct ObstaclePrefab: View {
    @Binding var changeIt : Bool
    @Binding var posX : Double
    @Binding var hitbox : Bool
    @Binding var getScore : Int
    @Binding var rexyPosY : Double
    @Binding var rexyMoment : RexyCases
    let opponentsGroup =  OpponentsCases.allCases
    @State private var image = ""
    
    var body: some View {
        HStack(alignment: .bottom){
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 90,height: 125)
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 29,height: 192)
                Text("\(String(format: "%.0f",posX))\n\(String(format: "%.0f",rexyPosY))")
                    .opacity(0)
                
             
            }
        }
       
        .onChange(of: changeIt, perform: { _ in
            image = opponentsGroup[opponentsGroup.indices.randomElement()!].imageName
        })
        
        //Cambio di hitbox che permette di ampliare il raggio di azione degli ostacoli rispetto al personaggio
        
        .onChange(of: posX) { newPosX in
            if rexyPosY > -30 && posX > 50 && posX < 180 {
                hitbox = true
                rexyMoment = .gameOver
            }
            if !hitbox && posX == 29 {
                let getRandomScore = Int.random(in: 7..<29)
                withAnimation(.spring()){
                    getScore += getRandomScore
                }
            }
            
        }
    }
}


struct OpponentsView_Previews: PreviewProvider {
    static var previews: some View {
        OpponentsView( hitbox: .constant(false), isGameStart: .constant(true), getScore: .constant(0), rexyPosY: .constant(-40), rexyMoment: .constant(.walk)).offset(x: 0, y: 0)
    }
}


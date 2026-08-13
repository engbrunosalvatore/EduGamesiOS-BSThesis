//
//  RexyView.swift
//  AppTesi1
//
//  Created by Salvatore Bruno on 12/04/23.
//

import SwiftUI

struct RexyView: View {

    @State private var rexyImage = UIImage(named: "rexyBase")!

    @Binding var rexyPosY: Double
    @State var rexyPosX = -129.0
    
    @Binding var rexyMoment : RexyCases
    let timer = Timer.publish(every: 0.0400, on: .main, in: .common).autoconnect()
    
    @State private var isJumping = false
    @State private var isFixPosX = false
    @Binding var isGameStart : Bool
    
    var body: some View {
        ZStack{
            rexyImageView
                .offset(x: rexyPosX, y: rexyPosY)
                .onAppear{
                    RexyState(state: rexyMoment)

                }
                .onChange(of: rexyMoment) { newRexyState in
                    RexyState(state: newRexyState)
                }
                .onTapGesture {

                    if rexyMoment == .walk {
                        RexyState(state: .jump)
                        isGameStart = true
                    }

                }
        }
        .onReceive(timer) { _ in
            
            
            if rexyMoment == .jump {
                if rexyPosY > -92 && !isJumping{
                    rexyPosY -= 14
                    
                }
                else if rexyPosY > -158 && !isJumping{
                    rexyPosY -= 10
                   
                }
                else if rexyPosY > -207 && !isJumping{
                    rexyPosY -= 5
                }
                
                else if rexyPosY < -7 && isJumping{
                    rexyPosY += 10
                }
                
                
                
                if rexyPosY <= -170 {
                    isJumping = true
                    isFixPosX = false
                }
                else if rexyPosY >= -7 && isJumping {
                    isJumping = false
                    RexyState(state: .walk)
                }
            }
            else if rexyMoment == .walk {
                if !isFixPosX {
                    isFixPosX.toggle()
                    
                }
            }
        }
    }
}
extension RexyView{
    
    private var rexyImageView: some View {

        Image(uiImage: rexyImage)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: 107)

    }

    func RexyState(state newRexyState: RexyCases){
        rexyMoment = newRexyState
        
        switch newRexyState {
        case .walk:
            rexyImage = UIImage(named: "\(rexyMoment.imageName)Left")!
            
            withAnimation(.spring(response: 0.04).repeatForever()){
                rexyImage = UIImage(named: "\(rexyMoment.imageName)Right")!
            }
        case .jump:
            rexyImage = UIImage(named: newRexyState.imageName)!
        default:
            rexyImage = UIImage(named: newRexyState.imageName)!
        }
    }

    
}
struct RexyView_Previews: PreviewProvider {
    static var previews: some View {
        RexyView(rexyPosY: .constant(0), rexyMoment: .constant(.walk), isGameStart: .constant(false))
    }
}

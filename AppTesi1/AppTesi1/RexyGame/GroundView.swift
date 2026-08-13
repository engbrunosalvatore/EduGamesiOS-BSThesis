//
//  GroundView.swift
//  AppTesi1
//
//  Created by Salvatore Bruno on 12/04/23.
//

import SwiftUI

struct GroundView: View {
    @State private var groundPosX = 900.0
    @Binding var rexyMoment : RexyCases
    
    var body: some View {
        
            ZStack{
                Image("way")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 2500)
                    .offset(x: groundPosX)
                    .opacity(rexyMoment != .gameOver ? 1 : 0)
                Image("way")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 2500)
                    .offset(x: 40)
                .opacity(rexyMoment != .gameOver ? 0 : 1)
            }
            .frame(width: 700)
            .clipped()
            .onAppear{
                withAnimation(.linear(duration: 12.9).repeatForever(autoreverses: false)){
                    groundPosX = -800
                }
            }
    }
}

struct GroundView_Previews: PreviewProvider {
    static var previews: some View {
        GroundView(rexyMoment: .constant(.walk))
    }
}

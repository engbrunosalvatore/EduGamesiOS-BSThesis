//
//  ProgressBar.swift
//  AppTesi1
//
//  Created by Salvatore Bruno on 25/03/23.
//


import SwiftUI

struct ProgressBar: View {
    var width: CGFloat = 200
    var height: CGFloat = 20
    var percent: CGFloat = 69
    var color1 = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    var color2 = Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
    
    var body: some View {
        let multiplier = width / 100
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: height , style: .continuous)
                .frame(width: width , height: height)
                .foregroundColor(Color.black.opacity(0.1))
            
            RoundedRectangle(cornerRadius: height , style: .continuous)
                .frame(width: percent * multiplier , height: height)
                .foregroundColor(Color.black.opacity(0.1))
                .background(
                    LinearGradient(gradient: Gradient(colors: [color2, color1 ]),
                    startPoint: .leading, endPoint: .trailing)
                    .clipShape(RoundedRectangle(cornerRadius: height , style: .continuous))
                    
                )
            
                .foregroundColor(.clear)
        }
     
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}

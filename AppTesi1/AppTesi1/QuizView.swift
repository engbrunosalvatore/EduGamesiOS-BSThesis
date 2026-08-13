//
//  QuizView().swift
//  AppTesi1
//
//  Created by Salvatore Bruno on 13/03/23.
//
import SwiftUI

struct QuizView: View {
    @EnvironmentObject var scoreManagerDay : ScoreManagerDay

    var body: some View {
      
        VStack(alignment: .center) {
            Text("Quiz del giorno").bold()
            HorizontalDatePickerView()
            HStack{
                Spacer()
                HStack {
                    Text("Punteggio Del giorno")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("\(scoreManagerDay.score)")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(10)
                .frame(maxWidth: 175)
            }
            
            Spacer()
            VStack {
             
/*
                Text("Livello 1")
                    .font(.system(size: 16, weight: .black, design: .rounded))
                    .foregroundColor(.blue)
                    .shadow(color: .black, radius: 0, x: 1, y: 2)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 1)
                    .background(
                        Capsule()
                            .fill(Color.white)
                            .shadow(color: .black, radius: 5, x: 2, y: 4)
                    )*/
                
                NavigationLink(destination: QuizHomePageView()) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .black, radius: 4, x: 2, y: 4)
                        .overlay(
                            VStack {
                                Image("Monster1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(15)
                                Text("Livello 1")
                                    .font(.system(size: 16, weight: .black, design: .rounded))
                                    .foregroundColor(.blue)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 6)
                                    .background(
                                      
                                            
                                    )
                            }
                        )
                        .frame(width: 330, height: 150)

                }
                
                
               Spacer()
            
                
                HStack(spacing: 20) {
                    NavigationLink(destination: QuizHomePageView()) {
                        VStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .shadow(color: .black, radius: 5, x: 1, y: 1)
                                .overlay(
                                    VStack {
                                        Image("Monster2")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(5)
                                        Text("Livello 2")
                                            .font(.system(size: 15, weight: .black, design: .rounded))
                                            .foregroundColor(.green)
                                            .padding(.horizontal, 5)
                                            .padding(.vertical, 6)
                                            .background(
                                              
                                                    
                                            )
                                    }
                                    )
                                .frame(width: 330, height: 150)
                            
                                }
                        }
                    
                }
                
                Spacer()
                
            }
           
        }
        .background(
                   Image("sfondo")
                       .resizable()
                       .aspectRatio(contentMode: .fill)
                       .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                           .padding(.top, -140)
               )
        
    }
}


struct QuizViewPreviews: PreviewProvider {
    static var previews: some View {
        QuizView()
            .environmentObject(ScoreManagerDay())
    }
}

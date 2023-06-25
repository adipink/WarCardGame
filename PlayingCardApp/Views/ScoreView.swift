//
//  ScoreView.swift
//  PlayingCardApp
//
//   Created by Kristina & Adi
//

import SwiftUI

struct ScoreView: View {
    @Binding var dispalyingCurApp: PlayingCardAppApp.CurrentScreen
    @Binding var playerScore: Int
    @Binding var pcScore: Int
    
    @State private var name = ""
    
    var body: some View {
        
            ZStack{
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack{
                    VStack{
                        Spacer()
                        Text("The Winner is").font(.largeTitle).fontWeight(.black).padding(.bottom, 5.0)
                        if playerScore >= pcScore {
                            Text("\(name)").font(.largeTitle).fontWeight(.black).padding(.bottom, 5.0)
                            Text(String(playerScore))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        } else {
                            Text("PC").font(.largeTitle).fontWeight(.black).padding(.bottom, 5.0)
                            Text(String(pcScore))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        
                    }.onAppear(){
                        name = UserDefaults.standard.string(forKey: "name") ?? "Player"
                    }.foregroundColor(Color.lightColor)
                    
                    Spacer()
                    Button{
                        dispalyingCurApp = .InitializationScreen
                    }
                    label: {
                        Image("restart")
                    }
                    
                    Spacer()
                }
            }
        }
    }




struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(dispalyingCurApp: .constant(.Score), playerScore: .constant(0), pcScore: .constant(0))
    }
}

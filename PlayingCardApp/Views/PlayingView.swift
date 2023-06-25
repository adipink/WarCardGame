//
//
//  PlayingCardApp

//   Created by Kristina & Adi
//

import SwiftUI

extension Color {
    static let lightColor = Color(red: 0.961, green: 0.966, blue: 0.874)
    static let lightGreen = Color(red: 0.418, green: 0.499, blue: 0.29)
}

struct PlayingView: View {
    @Binding var dispalyingCurApp: PlayingCardAppApp.CurrentScreen
    @Binding var playerScore: Int
    @Binding var pcScore: Int 

    
    @State  var playerCard = "card7"
    @State  var pcCard = "card13"
    
    
    //@State private var playerScore = 0
    @State var playerCardValue = 7
    
    //@State private var pcScore = 0
    @State var pcCardValue = 13
    
    @State var count = 0
    @State var countDownTimer = 5
    @State var timerRunning = true
    
    @State private var name = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
 
            ZStack{
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack{
                    Spacer()
                    
                    HStack{
                        
                        VStack{
                            Text("\(name)").font(.title).fontWeight(.black).padding(.bottom, 5.0)
                            Text(String(playerScore))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }.onAppear(){
                            name = UserDefaults.standard.string(forKey: "name") ?? "Player"
                        }
                        Spacer()
                        VStack{
                            Text("PC").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(.black).padding(.bottom, 5.0)
                            Text(String(pcScore))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        
                    }.foregroundColor(Color.lightColor).padding(.leading,20).padding(.trailing,20)
                    
                    Spacer()
                    HStack {
                        Spacer()
                        Image(playerCard)
                        
                        Spacer()
                        VStack{
                            Image("timer")
                            Text("\(countDownTimer)").font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.lightColor).padding(.leading,20)
                                .padding(.trailing,20).onReceive(timer){ timerOutput in
                                    if count < 10 {
                                        if countDownTimer > 0 && timerRunning {
                                            if countDownTimer == 2 {
                                                swipeBack()
                                            }
                                            countDownTimer -= 1
                                        } else {
                                            countDownTimer = 5
                                            count += 1
                                            swipe()
                                        }
                                    } else {
                                        timerRunning = false
                                        dispalyingCurApp = .Score
                                    }
                                }
                        }
                        
                        Spacer()
                        Image(pcCard)
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
    }
    
    
    func swipeBack() {
        playerCard = "cardback"
        pcCard = "cardback"
        
        //Update the scores
        if playerCardValue > pcCardValue {
            playerScore += 1
            
        } else if pcCardValue > playerCardValue{
            pcScore += 1
        }
    }
    
    func swipe (){
        //Randomize pc and player cards
        playerCardValue = Int.random(in: 2 ... 14)
        playerCard = "card" + String(playerCardValue)
        
        pcCardValue = Int.random(in: 2 ... 14)
        pcCard = "card" + String(pcCardValue)
    }
}

struct PlayingView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingView(dispalyingCurApp: .constant(.Playing), playerScore: .constant(0), pcScore: .constant(0))
    }
}

//
//  InitializationView.swift
//  PlayingCardApp
//
//  Created by Kristina on 15/06/2023.
//

import SwiftUI

struct InitializationView: View {
    @State private var showButton = true
    @State private var name = ""
    @State private var isPresentingNameEntry = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    VStack {
                        Spacer()
                        if showButton {
                            Button(action: {
                                isPresentingNameEntry = true
                            }) {
                                Text("Enter Name")
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundColor(Color.lightGreen)
                                    .padding()
                                    .background(Color.lightColor)
                                    .cornerRadius(10)
                            }
                            .sheet(isPresented: $isPresentingNameEntry) {
                                NameEntryView(name: $name, isPresented: $isPresentingNameEntry)
                            }
                        } else {
                            Text("Welcome, \(name)!")
                                .font(.headline)
                                .padding()
                        }
                    }
                    .onAppear {
                        showButton = !UserDefaults.standard.bool(forKey: "nameEntered")
                        name = UserDefaults.standard.string(forKey: "name") ?? ""
                    }
                    .onChange(of: name) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "name")
                    }
                    .onChange(of: showButton) { newValue in
                        UserDefaults.standard.set(!newValue, forKey: "nameEntered")
                    }
                    Spacer()
                    HStack {
                        VStack {
                            Image("halfLeft")
                            Text("West Side").font(.largeTitle)
                                .fontWeight(.bold).foregroundColor(Color.lightColor)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: PlayingView(), label: {
                            Image("start")
                        })
                        Spacer()
                        
                        VStack {
                            Image("halfRight")
                            Text("East Side").font(.largeTitle)
                                .fontWeight(.bold).foregroundColor(Color.lightColor)
                        }
                    }.padding(.leading,20).padding(.trailing,20)
                    
                    
                }
            }
        }
    }
}

struct NameEntryView: View {
    @Binding var name: String
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            TextField("Enter your name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                isPresented = false
            }) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct InitializationView_Previews: PreviewProvider {
    static var previews: some View {
        InitializationView()
    }
}

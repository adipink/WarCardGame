//
//  InitializationView.swift
//  PlayingCardApp
//
//  Created by Kristina on 15/06/2023.
//

import SwiftUI

struct InitializationView: View {
    let middleLongitude = 34.817549168324334
    @State private var showButton = true
    @State private var name = ""
    @State private var isPresentingNameEntry = false
    
    @StateObject var locationManager = LocationManager()
    
    @Binding var dispalyingCurApp: PlayingCardAppApp.CurrentScreen
    

    
    var body: some View {
            ZStack{
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    VStack {
                        Spacer()
                        if name.isEmpty {
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
                        if locationManager.longitude > middleLongitude {
                            Spacer()
                            
                            VStack {
                                Image("halfRight")
                                Text("East Side")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.lightColor)
                            }
                        } else {
                            VStack {
                                Image("halfLeft")
                                Text("West Side")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.lightColor)
                            }
                            
                            Spacer()
                        }
                        
                        VStack {
                            Button {
                                dispalyingCurApp = .Playing
                            } label: {
                                Image("start")
                            }
                            .disabled(name.isEmpty)
                            
                            switch locationManager.locationManager.authorizationStatus {
                            case .authorizedWhenInUse, .authorizedAlways:
                                Text("Longitude: \(locationManager.locationManager.location?.coordinate.longitude.description ?? "Error loading")")
                                    .fontWeight(.bold).foregroundColor(Color.lightColor)
                            case .notDetermined:
                                Text("Finding your location...")
                                    .fontWeight(.bold).foregroundColor(Color.lightColor)
                                ProgressView()
                            case .restricted ,.denied:
                                Text("Current location data was restricted or denied.")
                                    .fontWeight(.bold).foregroundColor(Color.lightColor)
                            @unknown default:
                                ProgressView()
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .onAppear {
                                locationManager.startUpdatingLocation()
                            }
                            .onDisappear {
                                locationManager.stopUpdatingLocation()
                            }
                    /*
                    HStack {
                        VStack {
                            Image("halfLeft")
                            Text("West Side").font(.largeTitle)
                                .fontWeight(.bold).foregroundColor(Color.lightColor)
                        }
                        Spacer()
                        VStack{
                            Button{
                                dispalyingCurApp = .Playing
                            } label: {
                                Image("start")
                            }.disabled(name.isEmpty)
                            
                            switch locationManager.locationManager.authorizationStatus {
                            case .authorizedWhenInUse:
                                Text("Longitude: \(locationManager.locationManager.location?.coordinate.longitude.description ?? "Error loading")")
                            case .notDetermined:
                                Text("Finding your location...")
                                                ProgressView()
                            case .restricted:
                                Text("Current location data was restricted or denied.")
                            case .denied:
                                Text("Current location data was restricted or denied.")
                            case .authorizedAlways:
                                Text("Longitude: \(locationManager.locationManager.location?.coordinate.longitude.description ?? "Error loading")")
                            @unknown default:
                                ProgressView()
                            }
                            
                        }
                        
                        Spacer()
                        
                        VStack {
                            Image("halfRight")
                            Text("East Side").font(.largeTitle)
                                .fontWeight(.bold).foregroundColor(Color.lightColor)
                        }
                    }.padding(.leading,20).padding(.trailing,20)
                             */
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
        InitializationView( dispalyingCurApp: .constant(.InitializationScreen))
    }
}

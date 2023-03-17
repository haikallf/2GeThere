//
//  ContentView.swift
//  2GeThere
//
//  Created by Haikal Lazuardi Fadil on 17/03/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color("primaryColor")
                    .ignoresSafeArea()
                
                VStack {
                    Header()
                    
                    FormButton()
                    
                    Text("SHOWING 20 TRIPS")
                        .font(.system(size: 12.0, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("gray4"))
                        .padding()
                    
                    ScrollView {
                        Card()
                        
                        Card()
                        
                        Card()
                        
                        Card()
                    }
                    
                    Spacer()
                    
                }.padding([.leading, .trailing], 16)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct Header: View {
    var body: some View {
       HStack {
            Spacer()
            
            VStack {
                Text("WELCOME, HAIKAL LAZUARDI!")
                    .font(.custom("Rubik", size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                Text("Afternoon Shift")
                    .font(.custom("Rubik", size: 12))
                    .fontWeight(.regular)
                    .padding(.top, 6)
                    .foregroundColor(Color("gray1"))
            }
            
            NavigationLink(destination: AuthView()) {
                VStack{
                    Image(systemName: "rectangle.portrait.and.arrow.forward")
                        .font(.system(size: 24.0, weight: .bold))
                        .rotation3DEffect(.degrees(180.0), axis: (x: 0, y: 0, z: 1))
                        .foregroundColor(.white)
                }
            }.offset(x: 50, y: 0)
            
            Spacer()
        }
        
        Divider()
            .frame(height: 1)
            .overlay(Color("gray2"))
    }
}

struct FormButton: View {
    var body: some View {
        NavigationLink(destination: FormView()) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Share a ride with another Academy Learners!")
                        .font(.custom("Rubik", size: 24))
                        .fontWeight(.thin)
                        .frame(maxWidth: 270, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 24.0, weight: .bold))
                    .opacity(0.5)
                    .padding(.top, 1)
                
            }
            .padding([.top, .bottom], 16)
            .padding([.leading, .trailing], 32)
            .foregroundColor(.black)
            .background(Color("yellow"))
            .cornerRadius(10)
        }.padding(.top)
    }
}

struct Card: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                HStack {
                    Image(systemName: "location.north.fill")
                        .font(.system(size: 12.0, weight: .regular))
                    
                    Text("LOCATION")
                        .font(.custom("Rubik", size: 12))
                        .fontWeight(.medium)
                }
                .foregroundColor(Color("gray1"))
                
                Spacer()
                
                
                Text("13.00 - 13.10")
                    .font(.custom("Rubik", size: 14))
                    .fontWeight(.medium)
                
                Text("Raize • B 1234 XYZ")
                    .font(.custom("Rubik", size: 12))
                    .fontWeight(.regular)
                
                Spacer()
                
                HStack {
                    Image(systemName: "person")
                        .font(.system(size: 24.0, weight: .regular))
                    
                    VStack (alignment: .leading) {
                        Text("Haikal Lazuardi")
                            .font(.custom("Rubik", size: 12))
                        
                        Text("+62 81219083250")
                            .font(.custom("Rubik", size: 12))
                    }
                }
                
                
            }.foregroundColor(.white)
            
            Spacer()
            
            VStack {
                Text("CAPACITY")
                    .font(.system(size: 14.0, weight: .medium))
                    .foregroundColor(Color("yellow"))
                
                Spacer()
                
                Text("2/6 Person")
                    .font(.system(size: 12.0, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("Join")
                    .frame(width: 92, height: 37)
                    .font(.system(size: 14.0, weight: .medium))
                    .foregroundColor(Color("yellow"))
                    .background(Color("primaryColor"))
                    .cornerRadius(15)
                    
                
            }
        }
        .frame(width: 305, height: 100)
        .padding()
        .background(Color("gray3"))
        .cornerRadius(15)
    }
}

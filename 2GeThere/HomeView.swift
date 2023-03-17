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
        
        .padding()
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
            .padding([.leading, .trailing], 24)
            .foregroundColor(.black)
            .background(Color("yellow"))
            .cornerRadius(10)
        }
    }
}

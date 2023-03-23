//
//  AuthView.swift
//  2GeThere
//
//  Created by Haikal Lazuardi Fadil on 17/03/23.
//

import SwiftUI

struct AuthView: View {
    @State var username: String = ""
    @State var pin: String = ""
    @State var hp: String = ""
    
    
    var body: some View {
            
            VStack {
                WelcomeText()
                LogoImage()
                TextField("Username", text: $username)
                    .padding()
                    .foregroundColor(.white)
                    .background(.gray)
                    .cornerRadius(5.0)
                    .padding(.bottom, 16)
                SecureField("PIN", text: $pin)
                    .padding()
                    .background(.gray)
                    .cornerRadius(5.0)
                    .padding(.bottom, 16)
                TextField("Phone", text: $hp)
                    .padding()
                    .background(.gray)
                    .cornerRadius(5.0)
                    .padding(.bottom, 16)
                Text("Register!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
        }
            .padding()
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

struct WelcomeText : View{
    var body: some View {
        return Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct LogoImage : View {
    var body: some View {
        return Image("logoImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(150)
                .padding(.bottom, 75)
        }
    }

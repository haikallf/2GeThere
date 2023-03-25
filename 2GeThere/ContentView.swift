//
//  ContentView.swift
//  2GeThere
//
//  Created by Haikal Lazuardi on 23/03/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var isUserCurrentlyLoggedOut: Bool = true
         
    var body: some View {
        NavigationView {
            ZStack {
                Color("Blue")
                    .ignoresSafeArea()
                ZStack {
                    Color.white
                        .ignoresSafeArea(.all, edges: [.leading, .trailing, .bottom])
                    VStack {
                        if !self.isUserCurrentlyLoggedOut {
                            HomeView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut, dataManager: _dataManager)
                        } else {
                            AuthView(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut, dataManager: _dataManager)
                        }
                        
                        Spacer()
                    }
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

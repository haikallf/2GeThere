//
//  ContentView.swift
//  2GeThere
//
//  Created by Haikal Lazuardi Fadil on 17/03/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct HomeView: View {
    @Binding var isUserCurrentlyLoggedOut: Bool
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("primaryColor")
                    .ignoresSafeArea()
                
                VStack {
                    Header(isUserCurrentlyLoggedOut: $isUserCurrentlyLoggedOut, dataManager: _dataManager)
                    
                    FormButton()
                    
                    Text("SHOWING \(dataManager.trips.count) TRIP(S)")
                        .font(.system(size: 12.0, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("gray4"))
                        .padding([.top, .bottom])
                    
                    ScrollView {
                        ForEach($dataManager.trips, id: \.id) { trip in
                            Card(id: trip.id, phone: trip.phone, fullname: trip.fullname, location: trip.location, license: trip.license, arrival: trip.arrival, departure: trip.departure, color: trip.color, vehicletype: trip.vehicletype, capacity: trip.capacity, members: trip.members)
                        }
                    }
                    
                    Spacer()
                    
                }
            }
        }
    }
    
}


struct Header: View {
    @Binding var isUserCurrentlyLoggedOut: Bool
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                
                VStack {
                    Text("WELCOME, \(dataManager.currentUser.fullname ?? "")!")
                        .font(.custom("Rubik", size: 12))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .textCase(.uppercase)
                    Text("\(dataManager.currentUser.shift?.capitalized ?? "") Shift")
                        .font(.custom("Rubik", size: 12))
                        .fontWeight(.regular)
                        .padding(.top, 6)
                        .foregroundColor(Color("gray1"))
                }
                Spacer()
            }
        
            
            Button {
                let firebaseAuth = Auth.auth()
                do {
                  try firebaseAuth.signOut()
                } catch let signOutError as NSError {
                  print("Error signing out: %@", signOutError)
                }
                isUserCurrentlyLoggedOut = true
            
            } label: {
                HStack {
                    Spacer()

                    Image(systemName: "rectangle.portrait.and.arrow.forward")
                        .font(.system(size: 24.0, weight: .bold))
                        .rotation3DEffect(.degrees(180.0), axis: (x: 0, y: 0, z: 1))
                        .foregroundColor(.white)
                }
            }
            
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
                        .fontWeight(.regular)
                        .frame(maxWidth: 270, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 24.0, weight: .bold))
                    .opacity(0.4)
                    .padding(.top, 1)
                
            }
            .offset(x: -20)
            .frame(maxWidth: .infinity)
            .padding([.top, .bottom], 16)
            .foregroundColor(.black)
            .background(Color("yellow"))
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
        .padding(.top)
    }
}

struct Card: View {
    @Binding var id: String
    @Binding var phone: String
    @Binding var fullname: String
    @Binding var location: String
    @Binding var license: String
    @Binding var arrival: Date
    @Binding var departure: Date
    @Binding var color: String
    @Binding var vehicletype: String
    @Binding var capacity: Int
    @Binding var members: [String]
    
    @EnvironmentObject var dataManager: DataManager
    
    
    func formatTime(time: Date) -> String {
        let dateFormatterTemplate = DateFormatter()
        dateFormatterTemplate.setLocalizedDateFormatFromTemplate("HH:mm")
        return dateFormatterTemplate.string(from: time)
    }
    
    func getCapacity(members: String) -> Int {
        var array = members.components(separatedBy: "++")
        array = array.filter({ $0 != ""})
        return array.count
    }
    
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                HStack {
                    Image(systemName: "location.north.fill")
                        .font(.system(size: 12.0, weight: .regular))
                    
                    Text("\(location)")
                        .font(.custom("Rubik", size: 12))
                        .fontWeight(.medium)
                }
                .foregroundColor(Color("gray1"))
                .padding(.bottom, 4)
                
                Spacer()
                
                Text("\(arrival, format: Date.FormatStyle().month().day()) • \(formatTime(time:arrival)) - \(departure, format: Date.FormatStyle().hour().minute())")
                    .font(.custom("Rubik", size: 14))
                    .fontWeight(.medium)
                
                Text("\(vehicletype.capitalized) • \(license.uppercased()) • \(color.capitalized)")
                    .font(.custom("Rubik", size: 12))
                    .fontWeight(.regular)
                
                Spacer()
                
                HStack {
                    Image(systemName: "person")
                        .font(.system(size: 24.0, weight: .regular))
                    
                    VStack (alignment: .leading) {
                        Text("\(fullname)")
                            .font(.custom("Rubik", size: 12))
                        
                        Text("+62 \(phone)")
                            .font(.custom("Rubik", size: 12))
                    }
                }
                .padding(.top, 4)
                
                
            }.foregroundColor(.white)
            
            Spacer()
            
            VStack {
                Text("CAPACITY")
                    .font(.system(size: 14.0, weight: .medium))
                    .foregroundColor(Color("yellow"))
                
                Spacer()
                
                Text("\(members.count)/\(capacity) Person")
                    .font(.system(size: 12.0, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    print("Join")
                } label: {
                    Text("Join")
                        .frame(width: 92, height: 37)
                        .font(.system(size: 14.0, weight: .medium))
                        .foregroundColor(Color("yellow"))
                        .background(Color("primaryColor"))
                        .cornerRadius(15)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
        .padding()
        .background(Color("gray3"))
        .cornerRadius(15)
    }
}

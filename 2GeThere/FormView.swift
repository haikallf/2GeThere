//
//  ContentView.swift
//  FormViewTrip
//
//  Created by Geraldy Kumara on 25/03/23.
//

import SwiftUI

struct FormView: View {
    @State private var location: String = ""
    @State private var date = Date()
    @State private var arrival = Date()
    @State private var departure = Date()
    @State private var vehicleType: String = ""
    @State private var vehicleColor: String = ""
    @State private var licensePlate: String = ""
    @State private var capacity: Int = 0
    
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
                VStack {
                    
                    Header1()
                    
                    VStack {
                        VStack (alignment: .leading){
                                TextField("Location", text: $location)
                                .padding(20)
                                .frame(maxHeight: 60)
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                                .overlay(RoundedRectangle(cornerRadius: 5.0).strokeBorder(Color("Gray"), style: StrokeStyle(lineWidth: 1)))
                        }

                        VStack (alignment: .leading){
                            DatePicker("Date", selection: $date, in: Date()..., displayedComponents: .date)
                                .padding(20)
                                .frame(maxHeight: 60)
                                .foregroundColor(Color("Gray"))
                                .font(.system(size: 15))
                                .overlay(RoundedRectangle(cornerRadius: 5.0).strokeBorder(Color("Gray"), style: StrokeStyle(lineWidth: 1)))
                        }                       .padding(.top, 13)

                        
                        VStack (alignment: .leading){
                            DatePicker("Arrival", selection: $arrival, in: date..., displayedComponents: .hourAndMinute)
                                .padding(20)
                                .frame(maxHeight: 60)
                                .foregroundColor(Color("Gray"))
                                .font(.system(size: 15))
                                .overlay(RoundedRectangle(cornerRadius: 5.0).strokeBorder(Color("Gray"), style: StrokeStyle(lineWidth: 1)))
                        }                       .padding(.top, 13)
                            
                        VStack (alignment: .leading){
                            DatePicker("Departure", selection: $departure, in: date..., displayedComponents: .hourAndMinute)
                                .padding(20)
                                .frame(maxHeight: 60)
                                .foregroundColor(Color("Gray"))
                                .font(.system(size: 15))
                                .overlay(RoundedRectangle(cornerRadius: 5.0).strokeBorder(Color("Gray"), style: StrokeStyle(lineWidth: 1)))
                        }                       .padding(.top, 13)
                        
                        HStack {
                            VStack (alignment: .leading){
                                TextField("Vehicle Type", text: $vehicleType)
                                .padding(20)
                                .font(.system(size: 15))
                                .overlay(RoundedRectangle(cornerRadius: 5.0).strokeBorder(Color("Gray"), style: StrokeStyle(lineWidth: 1)))
                            }
                            
                            
                            VStack (alignment: .leading){
                                TextField("Vehicle Color", text: $vehicleColor)
                                    .foregroundColor(.black)
                                    .padding(20)
                                    .font(.system(size: 15))
                                    .overlay(RoundedRectangle(cornerRadius: 5.0).strokeBorder(Color("Gray"), style: StrokeStyle(lineWidth: 1)))
                            }
                            .padding(.leading, 12)
                        }
                        .padding(.top, 13)
                        
                        HStack {
                            VStack (alignment: .leading){
                                TextField("License Plate", text: $licensePlate)
                                    .foregroundColor(.black)
                                    .padding(20)
                                    .font(.system(size: 15))
                                    .overlay(RoundedRectangle(cornerRadius: 5.0).strokeBorder(Color("Gray"), style: StrokeStyle(lineWidth: 1)))
                            }
                            
                            VStack (alignment: .leading){
                                TextField("Capacity", value: $capacity, formatter: NumberFormatter())
                                    .foregroundColor(.black)
                                    .padding(20)
                                    .font(.system(size: 15))
                                    .overlay(RoundedRectangle(cornerRadius: 5.0).strokeBorder(Color("Gray"), style: StrokeStyle(lineWidth: 1)))
                                }
                            .padding(.leading, 12)
                        }
                        .padding(.top, 13)
                    }
                    .padding()
                    .font(.system(size: 16.0, weight: .medium))
                    
                    Spacer()
                    
                    Button{
                        dataManager.addNewTrip(location: location, date: date, arrival: arrival, departure: departure, vehicletype: vehicleType, color: vehicleColor, license: licensePlate, capacity: capacity, fullname: dataManager.currentUser.fullname ?? "", phone: dataManager.currentUser.phone ?? "")
                    } label:  {
                        Text("Share")
                            .frame(maxWidth: 157, maxHeight: 55)
                    }
                    .foregroundColor(.white)
                    .buttonStyle(.bordered)
                    .background(Color("Blue"))
                    .cornerRadius(10)
                        
                }
                .navigationBarHidden(true)
                }
            }
    
    
    struct FormView_Previews: PreviewProvider {
        static var previews: some View {
            FormView()
        }
    }
    
struct Header1: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                
                VStack {
                    
                    Text("Join a Ride")
                        .font(.custom("Rubik", size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .textCase(.uppercase)
                }
                Spacer()
            }
        
            
            Button(action: { presentationMode.wrappedValue.dismiss() }, label: {
                HStack {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 24.0, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                }
            })
            
        }
        .ignoresSafeArea(.all, edges: [.leading, .trailing])
        .padding()
        .background(Color("Blue"))
        
    }
}
    
    
    struct ButtonView: View {
        var body: some View {
            Button{
                print("Share")
            } label:  {
                Text("Share")
                    .frame(maxWidth: 157, maxHeight: 55)
            }
            .foregroundColor(.white)
            .buttonStyle(.bordered)
            .background(Color("Blue"))
            .cornerRadius(10)
        }
    }

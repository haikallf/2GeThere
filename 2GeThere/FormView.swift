//
//  FormView.swift
//  2GeThere
//
//  Created by Haikal Lazuardi Fadil on 17/03/23.
//

import SwiftUI

struct FormView: View {
    @State private var location: String = ""
    @State private var meetMe: String = ""
    @State private var departAt: String = ""
    @State private var vehicleType: String = ""
    @State private var vehicileColor: String = ""
    @State private var licensePlate: String = ""
    @State private var capacity: Int = 1
    
    var body: some View {
        
            ZStack{
                Color("primaryColor")
                    .ignoresSafeArea()
                Header1()
                
                VStack {
                    

                    
                    VStack {
                        VStack (alignment: .leading){
                                Section(header: Text("PREFERRED RENDEZVOUS")){
                                    TextField("McD Plaza Sentral", text: $location)
                                        .foregroundColor(.white)
                                    }
                                .buttonStyle(.bordered)
                                .foregroundColor(.gray)
                            }
                        .frame(maxWidth: 335, maxHeight: 60)
                        .padding([.top, .leading])
                        .padding(.bottom, 10)
                        .background(Color("gray3"))
                        .cornerRadius(15)
                        
                        HStack {
                            VStack (alignment: .leading){
                                    Section(header: Text("MEET ME")){
                                        TextField("13.48", text: $meetMe)
                                            .foregroundColor(.white)
                                        }
                                    .buttonStyle(.bordered)
                                    .foregroundColor(.gray)
                                }
                            .frame(maxWidth: 147.5, maxHeight: 60)
                            .padding([.top, .leading])
                            .padding(.bottom, 10)
                            .background(Color("gray3"))
                            .cornerRadius(15)
                            
                            VStack (alignment: .leading){
                                    Section(header: Text("DEPART AT")){
                                        TextField("13.58", text: $departAt)
                                            .foregroundColor(.white)
                                        }
                                    .buttonStyle(.bordered)
                                    .foregroundColor(.gray)
                                }
                            .frame(maxWidth: 147.5, maxHeight: 60)
                            .padding([.top, .leading])
                            .padding(.bottom, 10)
                            .background(Color("gray3"))
                            .cornerRadius(15)
                        }
                        .padding(.top, 10)
                        
                        HStack {
                            VStack (alignment: .leading){
                                    Section(header: Text("VEHICLE TYPE")){
                                        TextField("Raize", text: $vehicleType)
                                            .foregroundColor(.white)
                                        }
                                    .buttonStyle(.bordered)
                                    .foregroundColor(.gray)
                                }
                            .frame(maxWidth: 147.5, maxHeight: 60)
                            .padding([.top, .leading])
                            .padding(.bottom, 10)
                            .background(Color("gray3"))
                            .cornerRadius(15)
                            
                            VStack (alignment: .leading){
                                    Section(header: Text("CAR COLOR")){
                                        TextField("BLACK", text: $vehicileColor)
                                            .foregroundColor(.white)
                                        }
                                    .buttonStyle(.bordered)
                                    .foregroundColor(.gray)
                                }
                            .frame(maxWidth: 147.5, maxHeight: 60)
                            .padding([.top, .leading])
                            .padding(.bottom, 10)
                            .background(Color("gray3"))
                            .cornerRadius(15)
                        }
                        .padding(.top, 10)
                        
                        HStack {
                            VStack (alignment: .leading){
                                    Section(header: Text("LICENSE PLATE")){
                                        TextField("B 1234 XYZ", text: $licensePlate)
                                            .foregroundColor(.white)
                                        }
                                    .buttonStyle(.bordered)
                                    .foregroundColor(.gray)
                                }
                            .frame(maxWidth: 147.5, maxHeight: 60)
                            .padding([.top, .leading])
                            .padding(.bottom, 10)
                            .background(Color("gray3"))
                            .cornerRadius(15)
                            
                            VStack (alignment: .leading){
                                    Section(header: Text("CAPACITY")){
                                        TextField("1", value: $capacity, formatter: NumberFormatter())
                                            .foregroundColor(.white)
                                        }
                                    .buttonStyle(.bordered)
                                    .foregroundColor(.gray)
                                }
                            .frame(maxWidth: 147.5, maxHeight: 60)
                            .padding([.top, .leading])
                            .padding(.bottom, 10)
                            .background(Color("gray3"))
                            .cornerRadius(15)
                        }
                        .padding(.top, 10)
                    }
                    .font(.system(size: 16.0, weight: .medium))
                    .padding()
                    
                    Spacer()
                    
                    ButtonView()
                        
                    }
                .padding()
                }
            .navigationBarBackButtonHidden(true)
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
                
                        Button(action: { presentationMode.wrappedValue.dismiss() }, label: {
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .font(.system(size: 24.0, weight: .bold))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        })
                
                
                HStack {
                    Spacer()
                    Text("Share a Ride")
                        .font(.custom("Rubik", size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            
            Divider()
                .frame(height: 1)
                .overlay(Color("gray2"))
                .padding(.bottom, 10)
        }
    }
    
    
    struct ButtonView: View {
        var body: some View {
            Button{
                print("Depart Now")
            } label:  {
                Text("Depart Now")
                    .frame(maxWidth: 157, maxHeight: 55)
            }
            .foregroundColor(.black)
            .buttonStyle(.bordered)
            .background(Color("yellow"))
            .cornerRadius(10)
        }
    }


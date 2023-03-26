//
//  AuthView.swift
//  2GeThere
//
//  Created by Haikal Lazuardi Fadil on 17/03/23.
//

import SwiftUI
import FirebaseAuth
import Firebase
let personSymbol = UIImage(named: "custom.person.fill")


struct AuthView: View {
    @Binding var isUserCurrentlyLoggedOut: Bool
    @EnvironmentObject var dataManager: DataManager
    @State var isLogin: Bool = true
    
    @State var email: String = ""
    @State var pin: String =  ""
    @State var phone: String =  ""
    @State var fullname: String =  ""
    @State var shift: String = "Morning Boys Broken Branch"
    
    @State var showingAlert = false
    @State var alertMessage = ""
    g
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: pin) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                dataManager.setCurrentUser(currentEmail: email)
                isUserCurrentlyLoggedOut = false
            }
        }
    }
    
    func register() {
        var phoneArray: [String] = phone.components(separatedBy: "")
        if phoneArray[0] == "0" {
            phoneArray.removeFirst()
        }
        
        let preprocessedPhone = phoneArray.joined(separator: "")
        
        Auth.auth().createUser(withEmail: email, password: pin) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                alertMessage = String(describing: error!.localizedDescription)
                showingAlert = true
            } else {
                let db = Firestore.firestore()
                let ref = db.collection("Users")
                ref.getDocuments {
                    snapshot, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    if let snapshot = snapshot {
                        for document in snapshot.documents {
                            let data = document.data()
                            let existhingPhone = data["phone"] as? String ?? ""
                            if (existhingPhone == preprocessedPhone) {
                                alertMessage = "Phone number already used"
                                showingAlert = true
                                return
                            }
                        }
                    }
                }
                
                
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let userData = ["email": email, "fullname": fullname, "phone": preprocessedPhone, "shift": shift, "uid": uid]
                Firestore.firestore().collection("Users")
                    .document(uid).setData(userData) { err in
                        if let err = err {
                            alertMessage = "\(err)"
                            showingAlert = true
                            return
                        }
                        alertMessage = "Register Success!"
                        showingAlert = true
                        
                        //                            dataManager.setCurrentUser(email: email)
                        //                            isUserCurrentlyLoggedOut = false
                    }
                //                dataManager.addNewUser(email: email, fullname: fullname, phone: phone, shift: shift)
                
            }
        }
    }
    
    
    var body: some View {
        VStack {
            VStack (alignment: .leading){
                //                Text("Welcome to 2GeThere!")
                //                    .padding()
                //                    .frame(maxWidth: 315, maxHeight: 60)
                //                    .foregroundColor(.black)
                //                    .font(.system(size: 15))
                //                    .buttonStyle(.bordered)
                //                    .border(Color("Black"))
                //                    .cornerRadius(2)
            }
            
            .padding(50)
            Image("2logo")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(.white)
                .background(Color.green)
                .clipShape(Circle())
                .padding(.bottom, 35)
            
            TextField("Enter your E-mail address", text: $email)
                .textInputAutocapitalization(.never)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0.5)))
                .padding()
            
            SecureField("PIN", text: $pin)
                .textInputAutocapitalization(.never)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0.5)))
                .padding()
            
            
            if (!isLogin) {
                TextField("Phone Number", text: $phone)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0.5)))
                    .padding()
                TextField("Full Name", text: $fullname)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0.5)))
                    .padding()
                
            }
                        Button {
                            if(isLogin) {
                                login()
                            }
                            else {
                                register()
                            }
            
                        } label: {
                            Text("\(isLogin ? "Login" : "Register")")
                                .frame(width: 157, height: 55)
                                .font(.system(size: 16.0, weight: .medium))
                                .background(Color(.blue))
                                .foregroundColor(Color(.white))
                                .cornerRadius(15)
                        }.alert("\(alertMessage)", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) {
                                showingAlert = false
                            }
                        }
            
                        .padding()
            
                        Button() {
                            self.isLogin = !self.isLogin
                            print($isLogin)
                        } label: {
                            if(isLogin) {
                                Group {
                                    Text("Don't have an account? ")
                                        .foregroundColor(Color.black) +
                                    Text("Register here ")
                                        .foregroundColor(Color.blue)
                                }
                            }
                            else {
                                Group {
                                    Text("Already a member? ")
                                        .foregroundColor(Color.black) +
                                    Text("Login here ")
                                    .foregroundColor(Color.blue)}
                                .padding()
                                
                            }
                        }
                    }
                }
            
                struct AuthView_Previews: PreviewProvider {
                    static var previews: some View {
                        AuthView(isUserCurrentlyLoggedOut: .constant(true))
                    }
                }
            }
            

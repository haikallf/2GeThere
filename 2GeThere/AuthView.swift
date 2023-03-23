//
//  AuthView.swift
//  2GeThere
//
//  Created by Haikal Lazuardi Fadil on 17/03/23.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct AuthView: View {
    @Binding var isUserCurrentlyLoggedOut: Bool
    @EnvironmentObject var dataManager: DataManager
    @State var isLogin: Bool = true
    
    @State var email: String = ""
    @State var pin: String =  ""
    @State var phone: String =  ""
    @State var fullname: String =  ""
    @State var shift: String = "morning"
    
    @State var showingAlert = false
    @State var alertMessage = ""
    
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
        
        var preprocessedPhone = phoneArray.joined(separator: "")
        
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
            TextField("EMAIL", text: $email)
                .textInputAutocapitalization(.never)
            
            SecureField("PIN", text: $pin)
                .keyboardType(.numberPad)
            
            if (!isLogin) {
                TextField("PHONE", text: $phone)
                    .keyboardType(.numberPad)
                TextField("FULLNAME", text: $fullname)
                    .textInputAutocapitalization(.never)
                Picker(selection: $shift, label: Text("Shift")) {
                    Text("Morning Shift").tag("morning")
                    Text("Afternoon Shift").tag("afternoon")
                }.pickerStyle(.segmented)

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
                    .frame(width: 92, height: 37)
                    .font(.system(size: 14.0, weight: .medium))
                    .foregroundColor(Color("yellow"))
                    .background(Color("primaryColor"))
                    .cornerRadius(15)
            }.alert("\(alertMessage)", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {
                    showingAlert = false
                }
            }
            
            Button() {
                self.isLogin = !self.isLogin
                print($isLogin)
            } label: {
                if(isLogin) {
                    Text("Don't have an account? Register")
                }
                else {
                    Text("Have an account? Login")
                }
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(isUserCurrentlyLoggedOut: .constant(true))
    }
}

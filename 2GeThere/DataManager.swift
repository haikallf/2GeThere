//
//  DataManager.swift
//  2GeThere
//
//  Created by Haikal Lazuardi Fadil on 21/03/23.
//

import Foundation
import Firebase

class DataManager: ObservableObject {
    @Published var trips: [Trip] = []
    @Published var currentUser: User = User(email: nil, fullname: nil, phone: nil, shift: nil)
    
    init() {
        fetchTrips()
    }
    
    func fetchTrips() {
        trips.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Trips")
        ref.getDocuments {
            snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let phone = data["phone"] as? String ?? ""
                    let fullname = data["fullname"] as? String ?? ""
                    let location = data["location"] as? String ?? ""
                    let license = data["license"] as? String ?? ""
                    let arrival = data["arrival"] as? Date ?? Date()
                    let departure = data["departure"] as? Date ?? Date()
                    let color = data["color"] as? String ?? ""
                    let vehicletype = data["vehicletype"] as? String ?? ""
                    let capacity = data["capacity"] as? Int ?? 0
                    var members = data["members"] as? String ?? ""
                    
                    var array = members.components(separatedBy: "++")
                    array = array.filter({ $0 != ""})
                    
                    let trip = Trip(id: id, phone: phone, fullname: fullname, location: location, license: license, arrival: arrival, departure: departure, color: color, vehicletype: vehicletype, capacity: capacity, members: array)
                    
                    self.trips.append(trip)
                }
            }
        }
    }
    
    func setCurrentUser(currentEmail: String) {
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
                    let email = data["email"] as? String ?? ""
                    if (email == currentEmail) {
                        let email = data["email"] as? String ?? ""
                        let fullname = data["fullname"] as? String ?? ""
                        let phone = data["phone"] as? String ?? ""
                        let shift = data["shift"] as? String ?? ""
                        self.currentUser = User(email: email, fullname: fullname, phone: phone, shift: shift)
                    }
                }
            }
        }
    }
    
    func addNewUser(email: String, fullname: String, phone: String, shift: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["email": email, "fullname": fullname, "phone": phone, "shift": shift, "uid": uid]
        Firestore.firestore().collection("Users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
            }
    }
        
    func updateCapacity(tripid: String, members: [String]) {
        let preprocessedMembers = members.joined(separator: "++")
        let db = Firestore.firestore()
        let users = db.collection("Trips")
        users.whereField("id", isEqualTo: tripid).limit(to: 1).getDocuments(completion: { querySnapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }

            guard let docs = querySnapshot?.documents else { return }

            for doc in docs {
                let docId = doc.documentID
//                let name = doc.get("name")
//                print(docId, name)

                let ref = doc.reference
                ref.updateData(["members": preprocessedMembers])
            }
        })
    }
    
    func getCapacity(tripid: String = "0") async -> Int {
        var capacity: Int = 0
        let db = Firestore.firestore()
        let ref = db.collection("Members").whereField("tripid", isEqualTo: tripid)
        await ref.getDocuments {
            snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for _ in snapshot.documents {
                    capacity = capacity + 1
                }
            }
        }
        print("masuk")
        return capacity
    }
    
}

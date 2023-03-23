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
    @Published var currentUser: User = User(id: nil, email: nil, fullname: nil, phone: nil)
    
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
    
    func fetchUserByPhone(phone: String = "81219083250") -> User {
        var user = User(id: nil, email: nil, fullname: nil, phone: nil)
        let db = Firestore.firestore()
        let ref = db.collection("Users").whereField("phone", isEqualTo: phone)
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
                    let email = data["email"] as? String ?? ""
                    let fullname = data["fullname"] as? String ?? ""
                    let phone = data["phone"] as? String ?? ""
                    
                    user =  User(id: id, email: email, fullname: fullname, phone: phone)
                }
            }
        }
        return user
        
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
//                    let data = document.data()
//                    let id = data["id"] as? String ?? ""
//                    let tripid = data["tripid"] as? String ?? ""
//                    let sharerider = data["sharerider"] as? String ?? ""
//                    let member = data["member"] as? String ?? ""
                    capacity = capacity + 1
                }
            }
        }
        print("masuk")
        return capacity
    }
    
//    func getCapacity2(tripid: String = "0") async throws -> [Member] {
//        var members: [Member] = []
//        let db = Firestore.firestore()
//        let ref = db.collection("Members").whereField("tripid", isEqualTo: tripid)
//        ref.getDocuments {
//            snapshot, error in
//            guard error == nil else {
//                print(error!.localizedDescription)
//                return
//            }
//
//            if let snapshot = snapshot {
//                for document in snapshot.documents {
//                    let data = document.data()
//                    let id = data["id"] as? String ?? ""
//                    let tripid = data["tripid"] as? String ?? ""
//                    let sharerider = data["sharerider"] as? String ?? ""
//                    let member = data["member"] as? String ?? ""
//
//                    members.append(Member(id: id, tripid: tripid, sharerider: sharerider, member: member))
//                }
//            }
//        }
//        return members
//    }
}
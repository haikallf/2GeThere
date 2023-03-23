//
//  Trip.swift
//  2GeThere
//
//  Created by Haikal Lazuardi Fadil on 21/03/23.
//

import Foundation

struct Trip: Identifiable {
    var id: String
    var phone: String
    var fullname: String
    var location: String
    var license: String
    var arrival: Date
    var departure: Date
    var color: String
    var vehicletype: String
    var capacity: Int
    var members: [String]
}

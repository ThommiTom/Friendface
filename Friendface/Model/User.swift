//
//  User.swift
//  Friendface
//
//  Created by Thomas Schatton on 16.05.22.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int16
    let company, email, address, about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

struct Friend: Identifiable, Codable {
    let id: UUID
    let name: String
}

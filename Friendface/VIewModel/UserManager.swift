//
//  UserManager.swift
//  Friendface
//
//  Created by Thomas Schatton on 16.05.22.
//

import Foundation

class UserManager: ObservableObject {
    @Published var users = [User]()
}

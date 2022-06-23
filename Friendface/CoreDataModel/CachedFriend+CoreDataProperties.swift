//
//  CachedFriend+CoreDataProperties.swift
//  Friendface
//
//  Created by Thomas Schatton on 17.05.22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var friendOfUser: NSSet?
    
    public var id_: UUID {
        id ?? UUID()
    }
    
    public var name_: String {
        name ?? "unknown name"
    }
    
    public var friendOfUser_: [CachedUser] {
        let set = friendOfUser as? Set<CachedUser> ?? []
        
        return set.sorted {
            $0.id < $1.id
        }
    }

}

// MARK: Generated accessors for friendOfUser
extension CachedFriend {

    @objc(addFriendOfUserObject:)
    @NSManaged public func addToFriendOfUser(_ value: CachedUser)

    @objc(removeFriendOfUserObject:)
    @NSManaged public func removeFromFriendOfUser(_ value: CachedUser)

    @objc(addFriendOfUser:)
    @NSManaged public func addToFriendOfUser(_ values: NSSet)

    @objc(removeFriendOfUser:)
    @NSManaged public func removeFromFriendOfUser(_ values: NSSet)

}

extension CachedFriend : Identifiable {

}

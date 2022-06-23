//
//  CachedUser+CoreDataProperties.swift
//  Friendface
//
//  Created by Thomas Schatton on 17.05.22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friendsList: NSSet?

    public var id_: UUID {
        id ?? UUID()
    }
    
    public var name_: String {
        name ?? "unknown name"
    }
    
    public var company_: String {
        company ?? "unknown company"
    }
    
    public var email_: String {
        email ?? "unknown email"
    }
    
    public var address_: String {
        address ?? "unknown address"
    }
    
    public var about_: String {
        about ?? "unknown info"
    }
    
    public var registered_: Date {
        registered ?? Date.init(timeIntervalSinceNow: 0)
    }
    
    public var tags_: String {
        tags ?? "no tags"
    }
    
    public var friendsList_: [CachedFriend] {
        let set = friendsList as? Set<CachedFriend> ?? []

        return set.sorted {
            $0.id < $1.id
        }
    }
}

// MARK: Generated accessors for friendsList
extension CachedUser {

    @objc(addFriendsListObject:)
    @NSManaged public func addToFriendsList(_ value: CachedFriend)

    @objc(removeFriendsListObject:)
    @NSManaged public func removeFromFriendsList(_ value: CachedFriend)

    @objc(addFriendsList:)
    @NSManaged public func addToFriendsList(_ values: NSSet)

    @objc(removeFriendsList:)
    @NSManaged public func removeFromFriendsList(_ values: NSSet)

}

extension CachedUser : Identifiable {

}

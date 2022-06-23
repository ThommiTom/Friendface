//
//  DetailUserView.swift
//  Friendface
//
//  Created by Thomas Schatton on 16.05.22.
//

import SwiftUI

struct DetailUserView: View {
    let user: CachedUser
    
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<CachedUser>
    
    var body: some View {
        VStack {
            List {
                Section("Contact information") {
                    HStack {
                        Circle()
                            .foregroundColor(user.isActive ? .green : .gray)
                            .frame(width: 15, height: 15)
                            .padding(.horizontal, 5)
                        Text(user.name_)
                    }
                    
                    Text(user.company_)
                    Text(user.email_)
                    Text(user.address_.replacingOccurrences(of: ", ", with: "\n"))
                }
                
                Section("About") {
                    Text(user.about_)
                        .multilineTextAlignment(.leading)
                    Text("Age: \(user.age)")
                    Text("Registered since \(user.registered_.formatted(date: .abbreviated, time: .omitted))")
                }
                
                Section("interests") {
                    Text(user.tags_)
                        .multilineTextAlignment(.leading)
                }
                
                Section("Friends with") {
                    ForEach(user.friendsList_) { friend in
                        let usersFriend = getFriend(id: friend.id_)
                        NavigationLink {
                            DetailUserView(user: usersFriend)
                        } label: {
                            HStack {
                                Circle()
                                    .foregroundColor(usersFriend.isActive ? .green : .gray)
                                    .frame(width: 15, height: 15)
                                    .padding(.horizontal, 5)
                                Text(usersFriend.name_)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(user.name_)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func getFriend(id: UUID) -> CachedUser {
        guard let user = users.first(where: { user in
            user.id == id
        }) else {
            print("did not found any users!")
            return CachedUser()
        }
        
        return user
    }
}

struct DetailUserView_Previews: PreviewProvider {
    static var previews: some View {
        DetailUserView(user: CachedUser())
    }
}

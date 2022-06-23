//
//  ContentView.swift
//  Friendface
//
//  Created by Thomas Schatton on 16.05.22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView {
            ZStack {
                if users.isEmpty {
                    ProgressView()
                }
                
                List(users) { user in
                    NavigationLink {
                        DetailUserView(user: user)
                    } label: {
                        HStack {
                            Circle()
                                .foregroundColor(user.isActive ? .green : .gray)
                                .frame(width: 15, height: 15)
                                .padding(.horizontal, 10)
                            
                            VStack(alignment: .leading) {
                                Text(user.name_)
                                    .font(.headline)
                                Text(user.company_)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .task {
                    if users.isEmpty {
                        await loadData()

                    }
                }
            }
            .navigationTitle("FriendFace")
        }
    }
    
    func loadData() async {
        // create a URL
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        print("created URL: \(url.absoluteString)")
        
        do {
            // retrieve data from URL
            let (data, _) = try await URLSession.shared.data(from: url)
            print("Downloaded data")
            
            // create decoder and setup strategy
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            // decode data
            let decodedUsers = try decoder.decode([User].self, from: data)
            let users: [User] = decodedUsers
            
            // fill up core data model with data
            await MainActor.run {
                writeDataToCoreData(users: users)
            }
            
            print("Successfully decoded data")
            
            
        } catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
        } catch {
            print("Invalid data")
        }
    }
    
    func writeDataToCoreData(users: [User]) {
        for user in users {
            let mocUser = CachedUser(context: moc)
            mocUser.id = user.id
            mocUser.isActive = user.isActive
            mocUser.name = user.name
            mocUser.age = user.age
            mocUser.company = user.company
            mocUser.email = user.email
            mocUser.address = user.address.replacingOccurrences(of: ", ", with: "\n")
            mocUser.about = user.about
            mocUser.registered = user.registered
            mocUser.tags = user.tags.joined(separator: ",")
            
            for friend in user.friends {
                let newFriend = CachedFriend(context: moc)
                newFriend.id = friend.id
                newFriend.name = friend.name
                
                mocUser.addToFriendsList(newFriend)
            }
        }
        
        if moc.hasChanges {
            try? moc.save()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

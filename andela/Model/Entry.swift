//
//  Entry.swift
//  andela
//
//  Created by Chris Karani on 12/18/19.
//  Copyright © 2019 Chris Karani. All rights reserved.
//

import Foundation

// this holds the raw data from the API
struct EntriesContainer: Codable {
    var count: Int
    var entries: [Entry]
}

//  an entry object
struct Entry {
    // todo: we can use coding keys to make this easier to read
    var api: String
    var description: String
    var auth: String
    var https: Bool
    var cors: String
    var link: String
    var category: String
}

extension Entry: Codable {
    
    // lets customise our codable object to make our code a little but more readable
     enum Keys: String, CodingKey {
         case api = "API"
         case description = "Description"
         case auth = "Auth"
         case https = "HTTPS"
         case cors = "Cors"
         case link = "Link"
         case category = "Category"
     }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        api = try container.decode(String.self, forKey: .api)
        description = try container.decode(String.self, forKey: .description)
        auth = try container.decode(String.self, forKey: .auth)
        https = try container.decode(Bool.self, forKey: .https)
        cors = try container.decode(String.self, forKey: .cors)
        link = try container.decode(String.self, forKey: .link)
        category = try container.decode(String.self, forKey: .category)
    }
}

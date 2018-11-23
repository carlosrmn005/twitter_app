//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-10-05.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation

class User
{
    // MARK: Properties
    var name: String?
    var screenName: String?
    var profilePicture: URL?
    var followers_count: Int?
    var friends_count: Int?
    var statuses_count: Int?
    var description: String?
   
    // Add any additional properties here
    static var current: User?
    
    init(dictionary: [String: Any])
    {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        if let profilePic: String = dictionary["profile_image_url_https"] as? String
        {
            profilePicture = URL(string: profilePic)!
        }
        // Initialize any other properties
        followers_count = dictionary["followers_count"] as? Int
        friends_count = dictionary["friends_count"] as? Int
        statuses_count = dictionary["statuses_count"] as? Int
        description = dictionary["description"] as? String
    }
}

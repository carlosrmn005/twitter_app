//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-10-05.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class User: NSObject
{
    // MARK: Properties
    var name: String?
    var screenName: String?
    
    // Add any additional properties here
    static var current: User?
    
    init(dictionary: [String: Any])
    {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        // Initialize any other properties
    }
}

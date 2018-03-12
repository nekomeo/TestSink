//
//  UserEmailInfo.swift
//  KitchenSink
//
//  Created by Elle Ti on 2018-03-12.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import Foundation

// Checks if user registered email account
public struct UserEmailInfo: Codable {
    
    public let email: String?
    public let unconfirmed_email: String?
    
}

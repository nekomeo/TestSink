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
    
    public let message: String?
    public let user_id: String?
    
}

public struct ClientInfoData: Codable {
    public let message: String
    public let client_id: String?
    public let client_secret: String?
}

public struct ClientAccessInfo: Codable {
    public let access_token: String?
    public let token_type: String?
    public let expires_in: String?
    public let scope: String?
    public let created_at: String?
    public let error: String?
    public let error_description: String?
}

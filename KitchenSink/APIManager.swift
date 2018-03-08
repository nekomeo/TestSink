//
//  APIManager.swift
//  KitchenSink
//
//  Created by Elle Ti on 2018-03-07.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import Foundation

public class APIManager {
    //    let serverAddress = "http://localhost:3000/v1/users"
    let serverAddress = "http://localhost:3000"
    
//    "user":{"email":"test@test.com"}
    
    var registrationAPIAddress: String
//    var token: String
    
    public init() {
        registrationAPIAddress = "\(serverAddress)/v1/users"
    }
}

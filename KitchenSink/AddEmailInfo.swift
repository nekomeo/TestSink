//
//  AddEmailInfo.swift
//  KitchenSink
//
//  Created by Elle Ti on 2018-03-12.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import Foundation

public struct SignUpInfo: Codable {
    public var token: String?
    public var error: String?
    public var errors: String?
    public var message: String?
    public var device_code: String?
}

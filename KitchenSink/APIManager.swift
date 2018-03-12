//
//  APIManager.swift
//  KitchenSink
//
//  Created by Elle Ti on 2018-03-07.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import Foundation
import UIKit

public class APIManager {
    //    let serverAddress = "http://localhost:3000/v1/users"
    let serverAddress = "http://localhost:3000"
    var token: String!
    
//    "user":{"email":"test@test.com"}
    
    var registrationAPIAddress: String
//    var token: String
    
    public init() {
        registrationAPIAddress = "\(serverAddress)/v1/users"
    }
    
    func createUser(completion: @escaping (Error?) -> ()) {
        guard let uuid = UIDevice.current.identifierForVendor?.uuidString else { fatalError("Could not identify device") }
        
        let url = URL(string: "\(registrationAPIAddress)")
        let jsonString = """
        {"user":{"device1": "\(uuid)"}}
        """
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = jsonString.data(using: .utf8)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(error)
            }
            else if let data = data {
                // Decode object
                let decoder = JSONDecoder()
                
                if let info = try? decoder.decode(SignUpInfo.self, from: data), let token = info.token {
                    self.token = token
                    print("Token: \(self.token)")
                    
//                    // Save jwt in keychain
//                    let keychain = KeychainHelper()
//                    keychain.saveToken(value: self.token)
                }
                completion(nil)
            }
        }.resume()
    }
    
    public func saveEmail(email: String, completion: @escaping (SignUpInfo?, Error?) -> ()) {
        
        let email = email.lowercased()
        
        let url = URL(string: "\(registrationAPIAddress)/add_email")
        let jsonString = """
        {"user":{"email": "\(email)"}}
        """
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonString.data(using: .utf8)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(nil, error)
            }
            else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let info = try decoder.decode(SignUpInfo.self, from: data)
                    completion(info, nil)
                }
                catch let jsonError {
                    completion(nil, jsonError)
                }
            }
        }.resume()
    }
    
    public func signInDevice(email: String, completion: @escaping (SignUpInfo?, Error?) -> ()) {
        let email = email.lowercased()
        
        let url = URL(string: "\(serverAddress)/v1/oauth/applications.json")
        let jsonString = """
        {"device":{"email": "\(email)"}}
        """
//        doorkeeper_application: {
//            name: "",
//            redirect_uri: "",
//            scopes: ['exchange'],
//            superapp: "true"
//        },
//        user: {
//            "email": "\(email)"
//        }
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = jsonString.data(using: .utf8)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(nil, error)
            }
            else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let info = try decoder.decode(SignUpInfo.self, from: data)
                    completion(info, nil)
                }
                catch let jsonError {
                    completion(nil, jsonError)
                }
            }
            
        }.resume()
    }
}

//
//  User.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 28.09.2021.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    // MARK: Public properties
    
    var isAuthorized: Bool {
        get {
            return UserDefaults.standard.string(forKey: "accessToken") != nil
        }
    }
    
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "accessToken")
        }
    }
    
    var userId: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "userId")
        }
    }
    // MARK: Init
    
    private init() {

    }
    
    
    // MARK: Public methods
    
    func saveUserToken(_ token: String, id: Int) {
        UserDefaults.standard.setValue(token, forKey: "accessToken")
        UserDefaults.standard.setValue(id, forKey: "userId")
    }
    
    func removeCredentials() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "userId")
    }
}

//
//  UserCache.swift
//  Zachetka
//
//  Created by Mikhail Lutskiy on 16.02.2018.
//  Copyright © 2018 BigBadBird. All rights reserved.
//

import Foundation

class UserCache: NSObject {
    
    /// Func for get login status
    ///
    /// - Returns: isLogin
    static func isLogin () -> Bool {
        return UserDefaults.standard.bool(forKey: "isLogin")
    }
    
    static func isClient () -> Bool {
        return UserDefaults.standard.bool(forKey: "isClient")
    }
    
    static func userId () -> Int {
        return UserDefaults.standard.integer(forKey: "user_id")
    }
    
    /// Func for change login state
    ///
    /// - Parameter loginState: isLogin
    static func changeLoginState (_ loginState: Bool) {
        UserDefaults.standard.set(loginState, forKey: "isLogin")
    }
    
    static func changeClientState (_ clientState: Bool) {
        UserDefaults.standard.set(clientState, forKey: "isClient")
    }
    
    static func setUserId (_ userId: Int) {
        UserDefaults.standard.set(userId, forKey: "user_id")
    }
    
}

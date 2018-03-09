//
//  Checker.swift
//  Zachetka
//
//  Created by Mikhail Lutskiy on 16.02.2018.
//  Copyright © 2018 BigBadBird. All rights reserved.
//

import Foundation

class Checker {
    
    /// This func check all fields for fill
    ///
    /// - Parameter fields: fields (only text)
    /// - Returns: fill or not
    static func checkFieldsForFill (_ fields:String...) -> Bool {
        var fill = true
        for field: String in fields {
            if field == "" {
                fill = false
            }
        }
        return fill
    }
}

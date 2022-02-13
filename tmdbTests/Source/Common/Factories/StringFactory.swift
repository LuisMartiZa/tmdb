//
//  StringFactory.swift
//  tmdbTests
//
//  Created by Luís Fernando Martínez Zarza on 13/2/22.
//

import Foundation

class StringFactory {

    enum StringFactoryDefinitions {
        static let defaultStringLength = 15
    }

    static func createRandomString(length: Int = StringFactoryDefinitions.defaultStringLength) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).compactMap{ _ in letters.randomElement() })
    }
    
    static func createEmptyString() -> String {
        return ""
    }
}

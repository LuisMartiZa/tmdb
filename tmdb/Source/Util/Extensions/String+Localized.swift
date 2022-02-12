//
//  String+Localized.swift
//  tmdb
//
//  Created by Luís Fernando Martínez Zarza on 12/2/22.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }

    func localized(param: CVarArg) -> String {
        String(format: self.localized, param)
    }

    func localized(params: [CVarArg]) -> String {
        String(format: self.localized, arguments: params)
    }
}

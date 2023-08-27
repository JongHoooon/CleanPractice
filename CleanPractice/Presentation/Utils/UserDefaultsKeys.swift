//
//  UserDefaultsKeys.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/27.
//

import Foundation

enum UserDefaultsKeys {
    case isLoggedIn
    
    var key: String {
        switch self {
        case .isLoggedIn:       return "isLoggedIn"
        }
    }
}

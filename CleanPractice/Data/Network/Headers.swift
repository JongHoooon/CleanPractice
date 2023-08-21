//
//  Headers.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import Alamofire

enum Headers {
    case accept
    case authorization

    var header: HTTPHeader {
        switch self {
        case .accept:
            return HTTPHeader(name: "accept", value: "application/json")
        case .authorization:
            return HTTPHeader(name: "Authorization", value: "Bearer \(APIKey.authorization)")
        }
    }
}


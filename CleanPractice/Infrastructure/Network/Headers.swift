//
//  Headers.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import Alamofire

enum Headers {
    static let accept = HTTPHeader(name: "accept", value: "application/json")
    static let authorization = HTTPHeader(name: "Authorization", value: "Bearer \(APIKey.authorization)")
}


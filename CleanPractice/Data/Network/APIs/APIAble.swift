//
//  APIAble.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import Alamofire

protocol APIable {
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
    var request: DataRequest { get }
}

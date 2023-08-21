//
//  CallRequestable.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import Alamofire

protocol CallRequestable {
    associatedtype APIType: APIable
}

extension CallRequestable {
    func callRequest<T: Decodable>(
        of: T.Type,
        movieAPI: APIType
    ) async throws -> T {
        
        let result = await movieAPI
            .request
            .validate()
            .serializingDecodable(T.self)
            .result
        
        switch result {
        case let .success(value):
            return value
        case let .failure(error):
            throw(error)
        }
    }
}

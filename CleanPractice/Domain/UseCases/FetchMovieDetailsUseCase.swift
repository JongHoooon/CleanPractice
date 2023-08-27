//
//  FetchMovieDetailUseCase.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import Foundation

protocol FetchMovieDetailsUseCase {
    func execute(id: Int) async throws -> VideoDetail
}

final class DefaultFetchMovieDetailsUseCase: FetchMovieDetailsUseCase {
        
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(id: Int) async throws -> VideoDetail {
        
        return try await movieRepository.fetchDetail(id: id)
    }
}

#warning("view model은 domain에 의존해도 괜찮은데 꼭 인터페이스를 써야하는지???")

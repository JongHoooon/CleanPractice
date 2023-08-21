//
//  FetchMovieDetailUseCase.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import Foundation

protocol FetchMovieDetailUseCase {
    func execute(id: Int) -> VideoDetail
}

final class DefaultFetchMovieDetailUseCase: FetchMovieDetailUseCase {
        
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(id: Int) -> VideoDetail {
        
        return movieRepository.fetchDetail(id: id)
    }
}

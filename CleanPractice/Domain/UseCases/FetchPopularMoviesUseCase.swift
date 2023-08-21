//
//  FetchPopularMoviesUseCase.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import Foundation

protocol FetchPopularMoviesUseCase {
    func execute(page: Int) -> [Video]
}

final class DefaultFetchPopularMoviesUseCase: FetchPopularMoviesUseCase {
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(page: Int) -> [Video] {
        
        return movieRepository.fetchPopular(page: page)
    }
}

//
//  FetchPopularTVSeriesUseCase.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/28.
//

import Foundation

protocol FectchPopularTVSeriesUseCase {
    func execute(page: Int) async throws -> VideosPage
}

final class DefaultFectchPopularTVSeriesUseCase: FectchPopularTVSeriesUseCase {
    
    private let tvSeriesRepository: TVSeriesRepository
    
    init(
        tvSeriesRepository: TVSeriesRepository
    ) {
        self.tvSeriesRepository = tvSeriesRepository
    }
    
    func execute(page: Int) async throws -> VideosPage {
        
        return try await tvSeriesRepository.fetchPopular(page: page)
    }
}

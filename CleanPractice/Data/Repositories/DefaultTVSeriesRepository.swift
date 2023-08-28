//
//  DefaultTVSeriesRepository.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/28.
//

import Foundation

final class DefaultTVSeriesRepository: TVSeriesRepository, CallRequestable {
    typealias APIType = VideoAPI
    
    func fetchPopular(page: Int) async throws -> VideosPage {
        do {
            let popularTVSeriesDTO = try await callRequest(
                of: PopularTVSeriesDTO.self,
                movieAPI: .fetchPopularTVSeries(page: page)
            )
            return popularTVSeriesDTO.toDomain()
        } catch {
            throw error
        }
    }
}

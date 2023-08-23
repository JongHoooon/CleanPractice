//
//  DefaultMovieRepository.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import Foundation

final class DefaultMovieRepository: MovieRepository, CallRequestable {
    typealias APIType = VideoAPI
    
    func fetchPopular(page: Int) async throws -> VideosPage {
        do {
            let popularMoviesDTO = try await callRequest(
                of: PopularMoviesResponseDTO.self,
                movieAPI: .fetchPopularMovies(page: page)
            )
            
            return popularMoviesDTO.toDomain()
        } catch {
            throw error
        }
    }

    func fetchDetail(id: Int) async throws -> VideoDetail {
        do {
            let movieDetailDTO = try await callRequest(
                of: VideoDetailResponseDTO.self,
                movieAPI: .fetchMovieDetail(id: id)
            )
            
            return movieDetailDTO.toDomain()
        } catch {
            throw error
        }
    }
}

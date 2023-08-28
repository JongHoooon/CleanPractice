//
//  TVSeriesRepository.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/28.
//

protocol TVSeriesRepository {
    func fetchPopular(page: Int) async throws -> VideosPage
}

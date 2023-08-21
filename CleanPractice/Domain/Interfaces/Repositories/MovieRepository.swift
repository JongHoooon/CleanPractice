//
//  MovieRepository.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

protocol MovieRepository {
    func fetchPopular(page: Int) -> [Video]
    func fetchDetail(id: Int) -> VideoDetail
}

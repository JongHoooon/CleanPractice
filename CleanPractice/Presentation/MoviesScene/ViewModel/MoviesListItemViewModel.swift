//
//  MoviesListItemViewModel.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/23.
//

import Foundation

import RxSwift
import RxRelay

#warning("example 에서는 viewModel을 왜 struct로 ??")
#warning("driver VS signal")
#warning("publish VS behavior")
#warning("view model은 domain 관련 정보 안담게는게 좋다??")
/*
 **Note**: This item view model is to display data and
 does not contain any domain model to prevent views
 accessing it
*/


final class MoviesListItemViewModel {
    
    // MARK: - Init
    init(movie: Video) {
        let infoText = "⭐️ \(String(format: "%.1f", movie.voteAverage))  \(movie.releaseDate)"
        titleTextRelay = .init(value: movie.title)
        infoTextRelay = .init(value: infoText)
        posterImagePath = .init(value: movie.posterPath)
    }
    
    // MARK: - Output
    let titleTextRelay: BehaviorRelay<String>
    let infoTextRelay: BehaviorRelay<String>
    let posterImagePath: BehaviorRelay<String>
}

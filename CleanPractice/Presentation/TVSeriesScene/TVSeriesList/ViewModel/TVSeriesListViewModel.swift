//
//  TVSeriesListViewModel.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/28.
//

import Foundation

struct TVSeriesListViewModelActions {
    let showLogin: () -> Void
}

protocol TVSeriesListViewModelInput {}

protocol TVSeriesListViewModelOutput {}

protocol TVSeriesListViewModel: TVSeriesListViewModelInput, TVSeriesListViewModelOutput {}

final class DefaultTVSeriesListViewModel: TVSeriesListViewModel {
    
    // MARK: - Properties
    private let actions: TVSeriesListViewModelActions
    
    // MARK: - Init
    init(actions: TVSeriesListViewModelActions) {
        self.actions = actions
    }
}


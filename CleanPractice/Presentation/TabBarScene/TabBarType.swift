//
//  TabBarType.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

enum TabBarType {
    case movies
    case tvSeries
    
    var title: String {
        switch self {
        case .movies:       return "영화"
        case .tvSeries:     return "TV"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .movies:       return ImageSpace.TabBarIcon.movie
        case .tvSeries:     return ImageSpace.TabBarIcon.tv
        }
    }
}

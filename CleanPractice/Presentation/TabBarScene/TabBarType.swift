//
//  TabBarType.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

enum TabBarType {
    case movies
    
    var title: String {
        switch self {
        case .movies:       return "영화"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .movies:       return ImageSpace.TabBarIcon.movie
        }
    }
}

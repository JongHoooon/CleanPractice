//
//  VideosListTableView.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/22.
//

import UIKit

final class VideosListTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        register(
            MoviesListItemCell.self,
            forCellReuseIdentifier: MoviesListItemCell.identifier
        )
        rowHeight = 100.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  MoviesListViewController.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import UIKit

final class MoviesListViewController: UIViewController {
    
    // MARK: - Property
    private let viewModel: MoviesListViewModel
    
    // MARK: - UI
    
    // MARK: - Init
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}

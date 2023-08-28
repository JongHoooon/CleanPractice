//
//  TVSeriesListViewController.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

final class TVSeriesListViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: TVSeriesListViewModel
    private let imageRepository: ImageRepository
    
    // MARK: - UI
    
    // MARK: - Init
    init(
        viewModel: TVSeriesListViewModel,
        imageRepository: ImageRepository
    ) {
        self.viewModel = viewModel
        self.imageRepository = imageRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
}

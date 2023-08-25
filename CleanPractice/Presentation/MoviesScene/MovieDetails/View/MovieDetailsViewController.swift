//
//  MovieDetailsViewController.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/23.
//

import UIKit

import RxSwift
import RxCocoa

final class MovieDetailsViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: MovieDetailsViewModel
    private let disposebag = DisposeBag()
    
    // MARK: - UI
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = ImageSpace.Placeholer.popcornImage
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = true
        return imageView
    }()
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = ImageSpace.Placeholer.popcornImage
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = true
        return imageView
    }()
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16.0
        return stackView
    }()
    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.text = "145분"
        return label
    }()
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.text = "⭐️ 9.99"
        return label
    }()
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.text = "over view 라벨입니다!over view 라벨입니다!over view 라벨입니다!over view 라벨입니다!over view 라벨입니다!over view 라벨입니다!over view 라벨입니다!over view 라벨입니다!over view 라벨입니다!over view 라벨입니다!over view 라벨입니다!"
        label.numberOfLines = 0
        return label
    }()
    private let popBarButton = UIBarButtonItem(
        image: ImageSpace.Icon.chevronLeft,
        style: .plain,
        target: nil,
        action: nil
    )
    
    // MARK: - Init
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configure()
        bind()
        viewModel.viewDidLoad()
    }
}

// MARK: - Bind
private extension MovieDetailsViewController {
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        popBarButton.rx.tap
            .bind(
                with: self,
                onNext: { owner, _ in
                    owner.viewModel.backButtonTapped()
                }
            )
            .disposed(by: disposebag)
    }
    
    func bindOutput() {
        viewModel.backdropImageDataRelay
            .map { UIImage(data: $0) }
            .asDriver(onErrorJustReturn: ImageSpace.Placeholer.popcornImage)
            .drive(backdropImageView.rx.image)
            .disposed(by: disposebag)
        
        viewModel.posterImageDataRelay
            .map { UIImage(data: $0) }
            .asDriver(onErrorJustReturn: ImageSpace.Placeholer.popcornImage)
            .drive(posterImageView.rx.image)
            .disposed(by: disposebag)
        
        viewModel.titleRelay
            .asSignal()
            .emit(to: navigationItem.rx.title)
            .disposed(by: disposebag)
        
        viewModel.runtimeRelay
            .asSignal()
            .emit(to: runtimeLabel.rx.text)
            .disposed(by: disposebag)
        
        viewModel.voteAverageRelay
            .asSignal()
            .emit(to: voteAverageLabel.rx.text)
            .disposed(by: disposebag)
        
        viewModel.overviewRelay
            .asSignal()
            .emit(to: overViewLabel.rx.text)
            .disposed(by: disposebag)
    }
}

// MARK: - Private
private extension MovieDetailsViewController {
    
    func configure() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        configureLayout()
    }
    
    func configureNavigationBar() {
        navigationItem.leftBarButtonItem = popBarButton
    }
    
    func configureLayout() {
        
        [
            runtimeLabel,
            voteAverageLabel,
            overViewLabel
        ].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        [
            backdropImageView,
            posterImageView,
            labelStackView
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            backdropImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            backdropImageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            backdropImageView.heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: 1/5
            ),
            
            posterImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16.0
            ),
            posterImageView.bottomAnchor.constraint(
                equalTo: backdropImageView.bottomAnchor
            ),
            posterImageView.heightAnchor.constraint(
                equalTo: backdropImageView.heightAnchor,
                multiplier: 3.0/4.0
            ),
            posterImageView.widthAnchor.constraint(
                equalTo: posterImageView.heightAnchor,
                multiplier: 2.0/3.0
            ),
            
            labelStackView.topAnchor.constraint(
                equalTo: backdropImageView.bottomAnchor,
                constant: 16.0
            ),
            labelStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16.0
            ),
            labelStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16.0
            ),
            labelStackView.bottomAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -16.0
            ),
        ])
        overViewLabel.setContentCompressionResistancePriority(
            .defaultLow,
            for: .vertical
        )
    }
}

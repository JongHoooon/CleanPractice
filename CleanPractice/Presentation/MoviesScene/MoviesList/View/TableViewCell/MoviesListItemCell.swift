//
//  MoviesListItemCell.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/23.
//

import UIKit

import RxSwift

#warning("view model 사용해 binding해주는게 맞는지???")
final class MoviesListItemCell: UITableViewCell {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private var viewModel: MoviesListItemViewModel?
    
    // MARK: - UI
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.image = ImageSpace.popcornImage
        
        return imageView   
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .bold)
        label.textColor = .label
        label.text = "오펜하이머"
        label.numberOfLines = 0
        
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        label.textColor = .label
        label.text = "⭐️ 9.9  2022-01-01"
        
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = nil
        infoLabel.text = nil
    }
    
    // MARK: - Bind
    func bind(
        viewModel: MoviesListItemViewModel,
        imageRepository: ImageRepository
    ) {
        self.viewModel = viewModel
        
        viewModel.titleTextRelay
            .asDriver()
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.infoTextRelay
            .asDriver()
            .drive(infoLabel.rx.text)
            .disposed(by: disposeBag)
        
        let imagePath = viewModel.posterImagePath.value
        Task {
            do {
                let imageData = try await imageRepository.fetchImage(imagePath: imagePath)
                posterImageView.image = UIImage(data: imageData)
            } catch {
                print(error)
                posterImageView.image = ImageSpace.popcornImage
            }
        }
    }
}

// MARK: - Private
private extension MoviesListItemCell {
    
    func configureLayout() {
        [
            posterImageView,
            titleLabel,
            infoLabel
        ].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            // posterImageView
            posterImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8.0
            ),
            posterImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -8.0
            ),
            posterImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 8.0
            ),
            posterImageView.widthAnchor.constraint(
                equalTo: posterImageView.heightAnchor,
                multiplier: 2.0/3.0
            ),
            
            // tileLabel
            titleLabel.topAnchor.constraint(
                equalTo: posterImageView.topAnchor
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: posterImageView.trailingAnchor,
                constant: 20.0
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: 20.0
            ),
            
            // infoLabel
            infoLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8.0
            ),
            infoLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),
            infoLabel.trailingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor
            )
        ])
    }
}

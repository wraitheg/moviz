//
//  MovieViewController.swift
//  Moviz
//
//  Created by Li Hao Lai on 21/12/20.
//

import UIKit
import RxSwift
import RxCocoa

class MovieViewController: UIViewController, ViewModelBasedType {
    typealias ViewModel = MovieViewModel
    
    var viewModel: MovieViewModel!
    
    private let disposeBag = DisposeBag()
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }
    
    func layout() {
        view.backgroundColor = .white
        
        [coverImageView, titleLabel, overviewLabel].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: view.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
    }
    
    func bind() {
        let output = viewModel.transform(input: .init())
        
        output.coverImageDriver
            .map { UIImage(data: $0) }
            .drive(coverImageView.rx.image)
            .disposed(by: disposeBag)
        
        output.movieTitleDriver
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.movieOverviewDriver
            .drive(overviewLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

//
//  ViewController.swift
//  Moviz
//
//  Created by Li Hao Lai on 31/10/20.
//

import UIKit
import RxSwift
import RxCocoa

class DiscoverViewController: UIViewController, ViewModelBasedType {
    typealias ViewModel = DiscoverViewModel
    
    var viewModel: DiscoverViewModel!
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 220
        tableView.contentInset = .init(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
        tableView.register(DiscoverCell.self, forCellReuseIdentifier: DiscoverCell.reuseIdentifier)
        
        return tableView
    }()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }

    private func layout() {
        title = "Discover"
        view.backgroundColor = .white
        
        [tableView].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bind() {
        let output = viewModel.transform(input: .init(
                                            didSelectMovieObservable: tableView.rx.modelSelected(Movie.self).asObservable()
        ))
        
        output.moviesDriver
            .drive(tableView.rx.items(cellIdentifier: DiscoverCell.reuseIdentifier)) { row, model, cell in
                guard let discoverCell = cell as? DiscoverCell else {
                    return
                }
                
                let vm = DiscoverCellViewModel(movie: model)
                discoverCell.bind(viewModel: vm)
            }
            .disposed(by: disposeBag)
        
        output.didSelectMovieDriver
            .drive(onNext: { [weak self] movie in
                let vm = MovieViewModel(movie: movie)
                let vc = MovieViewController.instantiate(viewModel: vm)
                
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}


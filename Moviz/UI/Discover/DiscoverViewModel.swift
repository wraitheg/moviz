//
//  DiscoverViewModel.swift
//  Moviz
//
//  Created by Li Hao Lai on 13/12/20.
//

import Foundation
import RxSwift
import RxCocoa

class DiscoverViewModel: ViewModelType {
    struct Input {
        let didSelectMovieObservable: Observable<Movie>
    }
    
    struct Output {
        let moviesDriver: Driver<[Movie]>
        let didSelectMovieDriver: Driver<Movie>
    }
    
    let service = DiscoverService()
    
    func transform(input: Input) -> Output {
        let moviesDriver = service.movie()
            .map { $0.results }
            .asDriver(onErrorDriveWith: .empty())
        
        let didSelectMovieDriver = input.didSelectMovieObservable
            .asDriver(onErrorDriveWith: .empty())
            
        return .init(
            moviesDriver: moviesDriver,
            didSelectMovieDriver: didSelectMovieDriver)
    }
}

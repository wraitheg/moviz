//
//  DiscoverCellViewModel.swift
//  Moviz
//
//  Created by Li Hao Lai on 14/12/20.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire

class DiscoverCellViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        let bgDataDriver: Driver<Data>
        let title: Driver<String>
        let releaseDate: Driver<String>
        let popularity: Driver<Double>
    }
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func transform(input: Input) -> Output {
        let bgDataDriver = RxAlamofire.requestData(.get, "https://image.tmdb.org/t/p/w500/\(movie.backdropPath)")
            .map { $0.1 }
            .asDriver(onErrorDriveWith: .empty())
            .debug()
        
        
        return .init(bgDataDriver: bgDataDriver,
                     title: .just(movie.title),
                     releaseDate: .just(movie.releaseDate),
                     popularity: .just(movie.voteAverage / 2))
    }
}

//
//  MovieViewModel.swift
//  Moviz
//
//  Created by Li Hao Lai on 21/12/20.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire

class MovieViewModel: ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        let coverImageDriver: Driver<Data>
        let movieTitleDriver: Driver<String>
        let movieOverviewDriver: Driver<String>
    }
    
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func transform(input: Input) -> Output {
        let coverImageDriver = RxAlamofire.requestData(.get, "https://image.tmdb.org/t/p/w500/\(movie.backdropPath)")
            .map { $0.1 }
            .asDriver(onErrorDriveWith: .empty())
        
        return .init(coverImageDriver: coverImageDriver,
                     movieTitleDriver: .just(movie.title),
                     movieOverviewDriver: .just(movie.overview))
    }
}

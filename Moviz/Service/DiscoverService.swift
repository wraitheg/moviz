//
//  DiscoverService.swift
//  Moviz
//
//  Created by Li Hao Lai on 25/11/20.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

protocol DiscoverServiceType {
    func movie() -> Single<MovieList>
}

final class DiscoverService {
    func movie() -> Single<MovieList> {
        RxAlamofire.requestDecodable(DiscoverRouter.movie)
            .asSingle()
            .map { $0.1 }
            .debug()
    }
}

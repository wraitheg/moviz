//
//  BaseProtocols.swift
//  AliasUI
//
//  Created by Li Hao Lai on 28/7/20.
//  Copyright © 2020 NE Digital. All rights reserved.
//

import UIKit

/// Defines a view model
protocol ViewModelType: AnyObject {}

/// Defines a behavior that it would have view models
protocol ViewModelBasedType: AnyObject {
  associatedtype ViewModel: ViewModelType
  var viewModel: ViewModel! { get set }
}

extension ViewModelBasedType where Self: UIViewController {
  /// Instantiate a view controlller and initalising it with a view model
  static func instantiate<ViewModel: ViewModelType>(viewModel: ViewModel) -> Self where ViewModel == Self.ViewModel {
    let viewController = Self()
    viewController.viewModel = viewModel
    return viewController
  }
}

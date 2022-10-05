//
//  HomeBuilder.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/04.
//

import UIKit

final class HomeBuilder {
  class func build() -> UIViewController {
    let viewController = HomeViewController()
    let useCase = HomeUseCaseImpl()
    let reactor = HomeViewReactor(useCase: useCase)
    viewController.reactor = reactor
    
    return viewController
  }
}

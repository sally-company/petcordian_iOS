//
//  StartingBuilder.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/16.
//

import UIKit

final class StartingBuilder {
  class func build() -> UIViewController {
    let viewController = StartingViewController()
    let useCase = StartingUseCaseImpl()
    let reactor = StartingViewReactor(useCase: useCase)
    viewController.reactor = reactor
    
    return viewController
  }
}

//
//  SplashBuilder.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/13.
//

import UIKit

final class SplashBuilder {
  class func build() -> UIViewController {
    let viewController = SplashViewController()
    let useCase = SplashUseCaseImpl()
    let reactor = SplashViewReactor(useCase: useCase)
    viewController.reactor = reactor
    
    return viewController
  }
}

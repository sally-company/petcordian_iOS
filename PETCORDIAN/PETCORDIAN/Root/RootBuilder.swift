//
//  RootBuilder.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/13.
//

import UIKit

final class RootBuilder {
  class func build() -> UIViewController {
    let viewController = RootViewController()
    let reactor = RootViewReactor(screenRouter: viewController)
    viewController.reactor = reactor
    
    return viewController
  }
}

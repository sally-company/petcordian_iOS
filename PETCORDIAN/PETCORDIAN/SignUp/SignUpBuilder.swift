//
//  SignUpBuilder.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/16.
//

import UIKit

final class SignUpBuilder {
  class func build() -> UIViewController {
    let viewController = SignUpViewController()
    let useCase = SignUpViewUseCaseImpl()
    let reactor = SignUpViewReactor(useCase: useCase)
    viewController.reactor = reactor
    
    return viewController
  }
}

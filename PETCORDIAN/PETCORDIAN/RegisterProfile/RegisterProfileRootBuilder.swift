//
//  RegisterProfileRootBuilder.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/20.
//

import UIKit

final class RegisterProfileRootBuilder {
  class func build() -> UIViewController {
    let viewController = RegisterProfileRootViewController()
    let reactor = RegisterProfileRootViewReactor()
    viewController.reactor = reactor
    
    return viewController
  }
}

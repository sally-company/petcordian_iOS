//
//  ProfileImageBuilder.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/21.
//

import UIKit

final class ProfileImageBuilder {
  class func build() -> UIViewController {
    let viewController = ProfileImageViewController()
    let useCase = ProfileImageUseCaseImpl()
    let reactor = ProfileImageViewReactor(useCase: useCase)
    viewController.reactor = reactor
    
    return viewController
  }
}

//
//  ProfileNameAgeBuilder.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/19.
//

import UIKit

final class ProfileNameAgeBuilder {
  class func build() -> UIViewController {
    let viewController = ProfileNameAgeViewController()
    let useCase = ProfileNameAgeUseCaseImpl()
    let reactor = ProfileNameAgeViewReactor(useCase: useCase)
    viewController.reactor = reactor
    
    return viewController
  }
}

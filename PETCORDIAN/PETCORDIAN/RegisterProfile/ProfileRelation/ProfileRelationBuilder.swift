//
//  ProfileRelationBuilder.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/21.
//

import UIKit

final class ProfileRelationBuilder {
  class func build(
    delegate: ProfileRelationViewControllerDelegate,
    name: String,
    age: String,
    gender: String
  ) -> UIViewController {
    let viewController = ProfileRelationViewController()
    let useCase = ProfileRelationUseCaseImpl()
    let reactor = ProfileRelationViewReactor(useCase: useCase,
                                             name: name,
                                             age: age,
                                             gender: gender)
    viewController.reactor = reactor
    viewController.delegate = delegate
    
    return viewController
  }
}

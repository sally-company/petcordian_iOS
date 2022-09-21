//
//  ProfileRelationBuilder.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/21.
//

import UIKit

final class ProfileRelationBuilder {
  class func build(delegate: ProfileRelationViewControllerDelegate) -> UIViewController {
    let viewController = ProfileRelationViewController()
    let useCase = ProfileRelationUseCaseImpl()
    let reactor = ProfileRelationViewReactor(useCase: useCase)
    viewController.reactor = reactor
    viewController.delegate = delegate
    
    return viewController
  }
}

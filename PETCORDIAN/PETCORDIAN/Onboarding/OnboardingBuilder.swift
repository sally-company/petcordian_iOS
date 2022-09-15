//
//  OnboardingBuilder.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/15.
//

import UIKit

final class OnboardingBuilder {
  class func build() -> UIViewController {
    let viewController = OnboardingViewController()
    let useCase = OnboardingUseCaseImpl()
    let reactor = OnboardingViewReactor(useCase: useCase)
    viewController.reactor = reactor
    
    return viewController
  }
}

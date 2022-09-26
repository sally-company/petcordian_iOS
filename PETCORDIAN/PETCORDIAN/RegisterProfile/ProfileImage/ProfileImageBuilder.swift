//
//  ProfileImageBuilder.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/21.
//

import UIKit

final class ProfileImageBuilder {
  class func build(
    name: String,
    age: String,
    gender: String,
    buttonText: String,
    textFieldText: String
  ) -> UIViewController {
    let viewController = ProfileImageViewController()
    let useCase = ProfileImageUseCaseImpl()
    let reactor = ProfileImageViewReactor(useCase: useCase,
                                          name: name,
                                          age: age,
                                          gender: gender,
                                          buttonText: buttonText,
                                          textFieldText: textFieldText)
    viewController.reactor = reactor
    
    return viewController
  }
}

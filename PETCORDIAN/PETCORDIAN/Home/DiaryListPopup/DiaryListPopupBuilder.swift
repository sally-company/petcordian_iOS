//
//  DiaryListPopupBuilder.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/10/06.
//

import UIKit

final class DiaryListPopupBuilder {
  class func build() -> UIViewController {
    let viewController = DiaryListPopupViewController()
    let useCase = DiaryListPopupUseCaseImpl()
    let reactor = DiaryListPopupViewReactor(useCase: useCase)
    viewController.reactor = reactor
    
    return viewController
  }
}

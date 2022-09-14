//
//  RootViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/13.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import UIKit

protocol ScreenRouter {
  func addOnboarding()
  func addStarting()
  func addHome()
  
  func removeStarting()
  func removeHome()
}

class RootViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = RootViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  weak var startingVC: UIViewController?
  weak var homeVC: UIViewController?
  
  // MARK: UI
  
  deinit {
    print("\(self)")
  }
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.reactor?.action.onNext(.viewDidLoad)
  }
  
  // MARK: Layout
  
  func bind(reactor: Reactor) {
  }
}

extension RootViewController: ScreenRouter {
  
  func addOnboarding() {
  }
  
  func addStarting() {
  }
  
  func addHome() {
  }
  
  func removeStarting() {
  }
  
  func removeHome() {
  }
  
  private func addChildVC(_ vc: UIViewController) {
    self.addChild(vc)
    vc.didMove(toParent: self)
    self.view.addSubview(vc.view)
    vc.view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func removeChildVC(_ viewController: UIViewController) {
    self.willMove(toParent: nil)
    viewController.view.removeFromSuperview()
    viewController.removeFromParent()
  }
}

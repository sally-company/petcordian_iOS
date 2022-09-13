//
//  SplashViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/13.
//

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

class SplashViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = SplashViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  // MARK: UI
  
  private let contentView = SplashContentView()
  
  deinit {
    print("\(self)")
  }
  
  // MARK: View Life Cycle
  
  override func loadView() {
    self.view = self.contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setup()
    self.bindViewDidLoad()
  }
  
  // MARK: Layout
  
  private func setup() {
    self.view.backgroundColor = .white
  }
  
  func bind(reactor: Reactor) {
    self.bindSuccess(reactor: reactor)
  }
  
  private func bindViewDidLoad() {
    self.reactor?.action.onNext(.viewDidLoad)
  }
  
  private func bindSuccess(reactor: Reactor) {
    reactor.pulse(\.$isSuccess)
      .distinctUntilChanged()
      .bind(onNext: { [weak self] isSuccess in isSuccess ?
        self?.removeSplashAndAddRoot() :
          .none
      })
      .disposed(by: self.disposeBag)
  }
  
  private func removeSplashAndAddRoot() {
    guard let navController = self.navigationController else { return }
    var navArray = navController.viewControllers
    navArray.remove(at: navArray.count - 1)
    let vc = UIViewController()
    vc.view.backgroundColor = .white
    navArray.append(vc)
    self.navigationController?.viewControllers = navArray
  }
}

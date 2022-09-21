//
//  ProfileRelationViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/21.
//

import ReactorKit
import RxCocoa
import RxKeyboard
import RxSwift
import UIKit

class ProfileRelationViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = ProfileRelationViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  var keyboardDispose: Disposable? = nil
  
  // MARK: UI
  
  private let contentView = ProfileRelationContentView()
  
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
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.installRxKeyboard()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    self.unInstallRxKeyboard()
  }
  
  // MARK: Layout
  
  private func setup() {
    self.view.backgroundColor = .white
  }
  
  func bind(reactor: Reactor) {
    
  }
  
  private func installRxKeyboard() {
    self.keyboardDispose = RxKeyboard.instance.visibleHeight
      .drive(onNext: { [weak self] keyboardVisibleHeight in
        guard let self = self else { return }
        
        UIView.animate(withDuration: 0) {
          self.contentView.petButton.snp.updateConstraints {
            if keyboardVisibleHeight > 0 {
              $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
                .offset(self.view.safeAreaInsets.bottom - keyboardVisibleHeight - 12)
            } else {
              $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-12)
            }
          }
        }
        self.view.layoutIfNeeded()
      })
  }
  
  private func unInstallRxKeyboard() {
    self.keyboardDispose?.dispose()
    self.keyboardDispose = nil
  }
}

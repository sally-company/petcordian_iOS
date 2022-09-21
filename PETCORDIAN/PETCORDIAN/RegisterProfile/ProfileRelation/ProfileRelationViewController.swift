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
import Then
import UIKit

protocol ProfileRelationViewControllerDelegate: AnyObject {
  func ProfileRelationViewControllerDidValidProfileRelation()
}

class ProfileRelationViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = ProfileRelationViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  var keyboardDispose: Disposable? = nil
  
  weak var delegate: ProfileRelationViewControllerDelegate?
  
  // MARK: UI
  
  private lazy var contentView = ProfileRelationContentView().then {
    $0.delegate = self
  }
  
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
    self.bindTypingText(reactor: reactor)
    self.bindNextButtonEnabled(reactor: reactor)
    self.bindNextButton()
  }
  
  func bindNextButton() {
    self.contentView.petButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(onNext: { [weak self] in
        self?.delegate?.ProfileRelationViewControllerDidValidProfileRelation()
      })
      .disposed(by: self.disposeBag)
  }
  
  func bindTypingText(reactor: Reactor) {
    self.contentView.textField.rx.text
      .skip(1)
      .distinctUntilChanged()
      .map { Reactor.Action.typingRelationText($0 ?? "") }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
  }
  
  func bindNextButtonEnabled(reactor: Reactor) {
    reactor.state
      .map { $0.isEnabled }
      .distinctUntilChanged()
      .bind(to: self.contentView.petButton.rx.isEnabled)
      .disposed(by: self.disposeBag)
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

extension ProfileRelationViewController: ProfileRelationContentViewDelegate {

  func ProfileRelationContentViewCellItemSelected(_ title: String) {
    reactor?.action.onNext(.selectRelationName(title))
    
    if title == "기타" {
      reactor?.action.onNext(.selectRelationName(""))
    }
  }
}

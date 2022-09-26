//
//  ProfileNameAgeViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/19.
//

import ReactorKit
import RxCocoa
import RxKeyboard
import RxSwift
import SnapKit
import UIKit

protocol ProfileNameAgeViewControllerDelegate: AnyObject {
  func profileNameAgeViewControllerDidValidProfileNameAge(name: String, age: String, gender: String)
}

class ProfileNameAgeViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = ProfileNameAgeViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  private let radioButtonController = RadioButtonController()
  
  var keyboardDispose: Disposable? = nil
  
  weak var delegate: ProfileNameAgeViewControllerDelegate?
  
  // MARK: UI
  
  private let contentView = ProfileNameAgeContentView()
  
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
    
    self.radioButtonController.buttonArray = [
      self.contentView.nameAgeInputView.manButton,
      self.contentView.nameAgeInputView.womanButton
    ]
    
    self.contentView.nameAgeInputView.manButton.addTarget(self, action: #selector(manButtonAction(_:)), for: .touchUpInside)
    self.contentView.nameAgeInputView.womanButton.addTarget(self, action: #selector(womanButtonAction(_:)), for: .touchUpInside)
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
  
  // MARK: Action
  
  @objc func manButtonAction(_ sender: UIButton) {
    self.radioButtonController.buttonArrayUpdated(buttonSelected: sender)
  }
  
  @objc func womanButtonAction(_ sender: UIButton) {
    self.radioButtonController.buttonArrayUpdated(buttonSelected: sender)
  }
  
  // MARK: Binding
  
  func bind(reactor: Reactor) {
    self.bindNextButton()
    self.bindTypingName(reactor: reactor)
    self.bindTypingAge(reactor: reactor)
    self.bindGenderButton(reactor: reactor)
    self.bindNextButtonEnabled(reactor: reactor)
  }
  
  func bindNextButton() {
    self.contentView.petButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(onNext: { [weak self] in
        guard let self = self else { return }
        self.delegate?.profileNameAgeViewControllerDidValidProfileNameAge(
          name: self.reactor?.currentState.name ?? "",
          age: self.reactor?.currentState.age ?? "",
          gender: self.radioButtonController.selectedButton?.titleLabel?.text ?? "")
      })
      .disposed(by: self.disposeBag)
  }
  
  func bindTypingName(reactor: Reactor) {
    self.contentView.nameAgeInputView.nameInputView.nameTextField.rx.text
      .skip(1)
      .distinctUntilChanged()
      .map { Reactor.Action.typingName($0 ?? "") }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
  }
  
  func bindTypingAge(reactor: Reactor) {
    self.contentView.nameAgeInputView.ageInputView.ageTextField.rx.text
      .skip(1)
      .distinctUntilChanged()
      .map { Reactor.Action.typingAge($0 ?? "") }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
  }
  
  func bindGenderButton(reactor: Reactor) {
    self.contentView.nameAgeInputView.manButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { Reactor.Action.selectGender(true) }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    self.contentView.nameAgeInputView.womanButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { Reactor.Action.selectGender(true) }
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

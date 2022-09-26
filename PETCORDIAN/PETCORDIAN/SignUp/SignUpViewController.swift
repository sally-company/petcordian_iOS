//
//  SignUpViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/16.
//

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

class SignUpViewController: UIViewController, ReactorKit.View {
  
  typealias Reactor = SignUpViewReactor
  
  // MARK: Properties
  
  var disposeBag: DisposeBag = .init()
  
  // MARK: UI
  
  private let contentView = SignUpContentView()
  
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
  
  // MARK: Layout
  
  private func setup() {
    self.view.backgroundColor = .white
  }
  
  func bind(reactor: Reactor) {
    self.bindKakaoLoginButton()
    self.bindGoogleLoginButton()
    self.bindNaverLoginButton()
  }
  
  func bindKakaoLoginButton() {
    self.contentView.actionView.kakaoLoginButtonView.button.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(onNext: { [weak self] in
        KakaoLoginDataManager.shared.login { token in
          print(token)
          self?.presentRegisterProfileScene()
        }
      })
      .disposed(by: self.disposeBag)
  }
  
  func bindGoogleLoginButton() {
    self.contentView.actionView.googleLoginButtonView.button.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(onNext: { [weak self] in self?.presentRegisterProfileScene() })
      .disposed(by: self.disposeBag)
  }
  
  func bindNaverLoginButton() {
    self.contentView.actionView.naverLoginButtonView.button.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(onNext: { [weak self] in self?.presentRegisterProfileScene() })
      .disposed(by: self.disposeBag)
  }
  
  private func presentRegisterProfileScene() {
    let registerProfileScene = RegisterProfileRootBuilder.build()
    let navController = UINavigationController(rootViewController: registerProfileScene)
    navController.modalPresentationStyle = .fullScreen
    self.present(navController, animated: true)
  }
}

//
//  SignUpViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/16.
//

import KakaoSDKAuth
import KakaoSDKUser
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
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    //do something
                    //_ = oauthToken
                  print("Token", oauthToken?.accessToken)
                  self?.presentRegisterProfileScene()
                }
            }
        } else {
          print("카카오톡이 설치되어 있지 않을 경우, 처리할 로직")
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

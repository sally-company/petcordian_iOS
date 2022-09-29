//
//  SignUpViewController.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/16.
//

import NaverThirdPartyLogin
import ReactorKit
import RxCocoa
import RxSwift
import Then
import UIKit

class SignUpViewController: BaseViewController, ReactorKit.View {
  
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
    NaverLoginDataManager.shared.loginInstance?.delegate = self
  }
  
  // MARK: Layout
  
  private func setup() {
    self.view.backgroundColor = .white
    self.navigationController?.isNavigationBarHidden = true
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
        KakaoLoginDataManager.shared.login { token, error in
          if let _ = error {
            self?.showAlert(title: "에러", message: SocialLoginError.KakaoLoginError.loginFailed.description, actionHandler: nil)
          }
          
          #if DEBUG
          print(token)
          #endif
          KakaoLoginDataManager.shared.getUserId { id, error in
            if let _ = error {
              self?.showAlert(title: "에러", message: SocialLoginError.KakaoLoginError.logoutFailed.description, actionHandler: nil)
            }
            
          #if DEBUG
          print(id)
          #endif
          }
        }
      })
      .disposed(by: self.disposeBag)
  }
  
  func bindGoogleLoginButton() {
    self.contentView.actionView.googleLoginButtonView.button.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(onNext: { [weak self] in
        guard let self = self else { return }
        GoogleLoginDataManager.shared.login(vc: self) { userId, error in
          if let _ = error {
            self.showAlert(title: "에러", message: SocialLoginError.GoogleLoginError.loginFailed.description, actionHandler: nil)
          }
          
          #if DEBUG
          print(userId)
          #endif
        }
      })
      .disposed(by: self.disposeBag)
  }
  
  func bindNaverLoginButton() {
    self.contentView.actionView.naverLoginButtonView.button.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind(onNext: { [weak self] in
        guard let self = self else { return }
        NaverLoginDataManager.shared.login()
      })
      .disposed(by: self.disposeBag)
  }
  
  private func presentRegisterProfileScene() {
    let registerProfileScene = RegisterProfileRootBuilder.build()
    let navController = UINavigationController(rootViewController: registerProfileScene)
    navController.modalPresentationStyle = .fullScreen
    self.present(navController, animated: true)
  }
}

extension SignUpViewController: NaverThirdPartyLoginConnectionDelegate {
  
  /// 로그인에 성공한 경우 호출
  func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    #if DEBUG
    print("Success login")
    #endif
    NaverLoginDataManager.shared.getInfo { id in
      #if DEBUG
      print(id)
      #endif
    }
  }
  
  /// referesh token(로그인 후 다시 로그인을 시도할 경우 호출)
  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    #if DEBUG
    print("Refresh Token", NaverLoginDataManager.shared.loginInstance?.accessToken)
    #endif
  }
  
  /// 연동 해제
  func oauth20ConnectionDidFinishDeleteToken() {
    #if DEBUG
    print("네이버 로그인 연동을 해제했습니다.")
    #endif
  }
  
  /// error
  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    #if DEBUG
    print("error = \(error.localizedDescription)")
    #endif
  }
}

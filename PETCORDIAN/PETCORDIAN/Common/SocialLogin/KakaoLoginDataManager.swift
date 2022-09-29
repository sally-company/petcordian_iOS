//
//  KakaoLoginDataManager.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/26.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class KakaoLoginDataManager {
  
  typealias Token = String
  
  static let shared = KakaoLoginDataManager()
  private init() { }
  
  func login(completion: @escaping (_ token: Token?, _ error: Error?) -> ()) {
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk {( oauthToken, error) in
        if let _ = error {
          DispatchQueue.main.async {
            completion(nil, error)
          }
        }
        else {
          print("loginWithKakaoTalk() success.")
          
          // AccessToken을 가져옴
          DispatchQueue.main.async {
            completion(oauthToken?.accessToken, nil)
          }
        }
      }
    } else {
      // 카카오톡이 설치되어 있지 않을 경우, 처리할 로직
      UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
        if let error = error {
          DispatchQueue.main.async {
            completion(nil, error)
          }
        }
        
        DispatchQueue.main.async {
          completion(oauthToken?.accessToken, nil)
        }
      }
    }
  }
  
  func logout(vc: BaseViewController, completion: @escaping () -> ()) {
    // 로그아웃은 요청 성공 여부와 관계없이 토큰을 삭제 처리
    UserApi.shared.logout {(error) in
      if let error = error {
        vc.showAlert(title: "에러", message: "로그아웃에 실패헀습니다\n\(error.localizedDescription).", actionHandler: nil)
      } else {
        DispatchQueue.main.async {
          completion()
        }
      }
    }
  }
  
  func getUserId(completion: @escaping (_ id: Int64?, _ error: Error?) -> ()) {
    UserApi.shared.me() {(user, error) in
      if let error = error {
        DispatchQueue.main.async {
          completion(nil, error)
        }
      }
      else {
        print("me() success.")
        
        // 유저 아이디를 가져옴
        DispatchQueue.main.async {
          completion(user?.id, nil)
        }
      }
    }
  }
  
  func deleteUser(vc: BaseViewController) {
    UserApi.shared.unlink { error in
      if let error = error {
        vc.showAlert(title: "에러", message: "카카오 연결 끊기에 실패헀습니다\n\(error.localizedDescription).", actionHandler: nil)
      } else {
        vc.showAlert(title: "알림", message: "카카오계정의 연결 상태를 해제했습니다.", actionHandler: nil)
      }
    }
  }
}

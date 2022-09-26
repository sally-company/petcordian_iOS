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
  
  static let shared = KakaoLoginDataManager()
  private init() { }
  
  func login(completion: @escaping (_ token: String?) -> ()) {
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        if let error = error {
          print(error)
        }
        else {
          print("loginWithKakaoTalk() success.")
          
          // AccessToken을 가져옴
          DispatchQueue.main.async {
            completion(oauthToken?.accessToken)
          }
        }
      }
    } else {
      print("카카오톡이 설치되어 있지 않을 경우, 처리할 로직")
    }
  }
  
  func logout(completion: @escaping () -> ()) {
    // 로그아웃은 요청 성공 여부와 관계없이 토큰을 삭제 처리
    UserApi.shared.logout {(error) in
      if let error = error {
        print(error)
      } else {
        DispatchQueue.main.async {
          completion()
        }
      }
    }
  }
  
  func getUserId(completion: @escaping (Int64?) -> ()) {
    UserApi.shared.me() {(user, error) in
      if let error = error {
        print(error)
      }
      else {
        print("me() success.")
        
        // 유저 아이디를 가져옴
        DispatchQueue.main.async {
          completion(user?.id)
        }
      }
    }
  }
}

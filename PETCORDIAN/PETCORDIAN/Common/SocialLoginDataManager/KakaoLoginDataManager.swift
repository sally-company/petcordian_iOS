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
          
          DispatchQueue.main.async {
            completion(oauthToken?.accessToken)
          }
        }
      }
    } else {
      print("카카오톡이 설치되어 있지 않을 경우, 처리할 로직")
    }
  }
}

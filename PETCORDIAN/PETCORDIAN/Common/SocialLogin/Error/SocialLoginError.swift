//
//  SocialLoginError.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/28.
//

import Foundation

enum SocialLoginError {
  enum KakaoLoginError: Error {
    case loginFailed
    case logoutFailed
    case getUserIdFailed
    case unlinkFailed
    
    var description: String {
      switch self {
      case .loginFailed:
        return "앱 로그인에 실패했습니다."
      
      case .logoutFailed:
        return "로그아웃에 실패했습니다."
        
      case .getUserIdFailed:
        return "유저 정보를 가져오지 못했습니다."
        
      case .unlinkFailed:
        return "카카오계정 연결 끊기에 실패헀습니다."
      }
    }
  }
  
  enum GoogleLoginError: Error {
    case loginFailed
    case logoutFailed
    case getUserIdFailed
    case unlinkFailed
    
    var description: String {
      switch self {
      case .loginFailed:
        return "앱 로그인에 실패했습니다."
      
      case .logoutFailed:
        return "로그아웃에 실패했습니다."
        
      case .getUserIdFailed:
        return "유저 정보를 가져오지 못했습니다."
        
      case .unlinkFailed:
        return "구글계정 연결 끊기에 실패헀습니다."
      }
    }
  }
  
  enum NaverLoginError: Error {
    case loginFailed
    case logoutFailed
    case getUserIdFailed
    case unlinkFailed
    
    var description: String {
      switch self {
      case .loginFailed:
        return "앱 로그인에 실패했습니다."
      
      case .logoutFailed:
        return "로그아웃에 실패했습니다."
        
      case .getUserIdFailed:
        return "유저 정보를 가져오지 못했습니다."
        
      case .unlinkFailed:
        return "네이버계정 연결 끊기에 실패헀습니다."
      }
    }
  }
}

//
//  NaverLoginDataManager.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/28.
//

import Alamofire
import Foundation
import NaverThirdPartyLogin

class NaverLoginDataManager {
  
  static let shared = NaverLoginDataManager()
  private init() { }
  
  public let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
  
  func login() {
    self.loginInstance?.requestThirdPartyLogin()
  }
  
  func logout() {
    self.loginInstance?.resetToken()
    #if DEBUG
    print("로그아웃 성공")
    #endif
  }
  
  func getInfo(completion: @escaping (_ id: String) -> ()) {
    guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
    
    if !isValidAccessToken {
      return
    }
    
    guard let tokenType = loginInstance?.tokenType else { return }
    guard let accessToken = loginInstance?.accessToken else { return }
    
    let urlStr = "https://openapi.naver.com/v1/nid/me"
    let url = URL(string: urlStr)!
    
    let authorization = "\(tokenType) \(accessToken)"
    
    let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
    
    req.responseJSON { response in
      guard let result = response.value as? [String: Any] else { return }
      guard let object = result["response"] as? [String: Any] else { return }
      guard let id = object["id"] as? String else {return}
      
      DispatchQueue.main.async {
        completion(id)
      }
    }
  }
  
  func deleteUser() {
    self.loginInstance?.requestDeleteToken()
  }
}

//
//  GoogleLoginDataManager.swift
//  PETCORDIAN
//
//  Created by Hyunwoo Jang on 2022/09/27.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class GoogleLoginDataManager {
  
  static let shared = GoogleLoginDataManager()
  private init() { }
  
  func signIn(vc: BaseViewController) {
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    
    let config = GIDConfiguration(clientID: clientID)
    
    GIDSignIn.sharedInstance.signIn(with: config, presenting: vc) { [unowned self] user, error in
      
      if let error = error {
        vc.showAlert(title: "에러", message: error.localizedDescription, actionHandler: nil)
        return
      }
      
      guard
        let authentication = user?.authentication,
        let idToken = authentication.idToken
      else {
        return
      }
      
      // 사용자 인증 정보
      let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                     accessToken: authentication.accessToken)
      
      Auth.auth().signIn(with: credential) { authDataResult, error in
        if let error = error {
          vc.showAlert(title: "에러", message: error.localizedDescription, actionHandler: nil)
          return
        }
        
        print("access token", authentication.accessToken)
        print("user.uid", authDataResult?.user.uid ?? "")
        print("providerID", authDataResult?.additionalUserInfo?.providerID ?? "")
        print("user.email", authDataResult?.user.email ?? "")
      }
    }
  }
  
  func signOut(vc: BaseViewController) {
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
      #if DEBUG
      print("로그아웃 성공")
      #endif
    } catch let signOutError as NSError {
      vc.showAlert(title: "에러", message: "Error signing out: \(signOutError)", actionHandler: nil)
    }
  }
}
